#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'
require 'pry'

class MemberList
  # details for an individual member
  class Member < Scraped::HTML
    PREFIXES = %w[Rt Hon Dr].freeze

    field :name do
      PREFIXES.reduce(full_name) { |current, prefix| current.sub("#{prefix} ", '') }
    end

    # Only part of the string is a link in many cases, so we need to
    # find the containing text, but these aren't in separate nodes, so
    # this gets quite fiddly.
    field :position do
      all_minister_positions.find { |str| str.include? portfolio_url }.gsub(/<.*?>/, '').tidy
    end

    private

    def full_name
      noko.xpath('preceding-sibling::h4').text.tidy
    end

    def portfolio_url
      noko.attr('href').split('/').last
    end

    def all_minister_positions
      noko.parent.to_html.gsub(%r{.*/h4>}, '').split('<br>')
    end
  end

  # The page listing all the members
  class Members < Scraped::HTML
    field :members do
      member_container.map { |member| fragment(member => Member).to_h }
    end

    private

    def member_container
      noko.css('.view-content table').first.xpath('.//tr//td[2]//a')
    end
  end
end

url = 'https://dpmc.govt.nz/our-business-units/cabinet-office/ministers-and-their-portfolios/ministerial-list'
puts EveryPoliticianScraper::ScraperData.new(url).csv
