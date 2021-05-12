const cds = require('@sap/cds')
module.exports = cds.service.impl (async function(){ 
  //const SomeOtherService = await cds.connect.to('SomeOtherService')
  //const srv = await cds.connect.to('Vaccination_Center')
  this.before('READ', 'VaccinationCenters', function(){
      console.log("\n---------------------------\nReading vaccination centers\n---------------------------\n");
  })
  this.on("calculateRaccomandedVaccine", function(req){
      return Math.round(req.data.num_booked*(req.data.rt + 0.5))
  })
  
})