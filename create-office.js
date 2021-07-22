// wd create-entity create-office.js "Minister for X"
module.exports = (label) => {
  return {
    type: 'item',
    labels: {
      en: label,
    },
    descriptions: {
      en: 'New Zealand Cabinet position',
    },
    claims: {
      P31:   { value: 'Q294414' }, // instance of: public office
      P279:  { value: 'Q83307'  }, // subclas of: minister
      P17:   { value: 'Q664'    }, // country: New Zealand
      P1001: { value: 'Q664'    }, // jurisdiction: New Zealand
      P361: {
        value: 'Q2932373',         // part of: Cabinet of New Zealand
        references: {
          P854: 'https://dpmc.govt.nz/our-business-units/cabinet-office/ministers-and-their-portfolios/ministerial-list'
        },
      }
    }
  }
}
