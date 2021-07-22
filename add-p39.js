module.exports = (id, position, startdate) => ({
  id,
  claims: {
    P39: {
      value: position,
      qualifiers: {
        P580: startdate,   // need to pass this, as they're too varied
        P5054: 'Q42314738' // Sixth Labour Government of New Zealand
      },
      references: {
        P854: 'https://dpmc.govt.nz/our-business-units/cabinet-office/ministers-and-their-portfolios/ministerial-list',
        P1476: {
          text: 'Ministerial List',
          language: 'en',
        },
        P813: new Date().toISOString().split('T')[0],
        P407: 'Q1860', // language: English
      }
    }
  }
})
