#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full:     noko.xpath('preceding-sibling::h4').text,
        prefixes: %w[Rt Hon Dr]
      ).short
    end

    # Only part of the string is a link in many cases, so we need to
    # find the containing text, but these aren't in separate nodes, so
    # this gets quite fiddly.
    field :position do
      all_minister_positions.find { |str| str.include? portfolio_url }.gsub(/<.*?>/, '').tidy
    end

    private

    def portfolio_url
      noko.attr('href').split('/').last
    end

    def all_minister_positions
      noko.parent.to_html.gsub(%r{.*/h4>}, '').split('<br>')
    end
  end

  class Members
    def member_container
      noko.css('.view-content table').first.xpath('.//tr//td[2]//a')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
