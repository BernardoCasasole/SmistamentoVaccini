const cds = require('@sap/cds')
module.exports = cds.service.impl(async function () {
    //const SomeOtherService = await cds.connect.to('SomeOtherService')
    //const srv = await cds.connect.to('Vaccination_Center')
    this.before('READ', 'VaccinationCenters', function () {
        console.log("\n---------------------------\nReading vaccination centers\n---------------------------\n");
    })


    this.on("calculateRaccomandedVaccine", async function () {
        var result = await SELECT.from('VaccinationCenters');
   
        var amount = 0;
        var ID = "";

        for (var i=0; i< result.length; i++) {
            var righe = await SELECT.from('BookedVaccines').where({ completed: false, vaccinationCenter_ID : result[i].ID});
            var nuemroRighe = righe.length;
            amount = Math.round(nuemroRighe * (0.5 + result[i].rt));
            ID = result[i].ID;
           // let [ ID, amount ] = [ ID, amount ]
           await UPDATE ('VaccinationCenters',ID).with ({
   recomendedVaccines: amount
});
           // await UPDATE `vaccination.center.VaccinationCenters`.set `recomendedVaccines = ${amount}`.where `ID = ${ID}`;

        }
        
        return 0;
    })

    this.on("updateVaccCenterVaccines", async function(req){
        var sortingCenter_row = await SELECT.one.from('SortingCenters');
        var tot_vacc = sortingCenter_row.availableVaccines;

        var sortingCenter_row_2 = await SELECT.one.from('VaccinationCenters').where({ID : req.data.id_vacc_center});
        var tot_vacc_2 = sortingCenter_row_2.availableVaccines;

        await UPDATE ('SortingCenters').with ({availableVaccines : tot_vacc - req.data.asingedVaccines});
        await UPDATE ('VaccinationCenters', req.data.id_vacc_center).with ({availableVaccines : tot_vacc_2 + req.data.asingedVaccines});
        //let [amount]=[1];  
        //await UPDATE ('SortingCenters') .set `availableVaccines = availableVaccines - ${amount}`
        //await UPDATE.entity `SortingCenters` .set `availableVaccines = availableVaccines - ${req.data.asingedVaccines}`;
        //await UPDATE.entity `VaccinationCenters` .set `availableVaccines = availableVaccines + ${req.data.asingedVaccines}`;
       
        return 0;
    })
    /*
    this.on("getVaccinesTodo", async function(req){
        var righe = await SELECT.from('BookedVaccines').where({ completed: false, vaccinationCenter: req.data.vacc_center_id});
        var nuemroRighe = righe.length;
        await UPDATE.entity `VaccinationCenters` .set `BookedVaccines = ${nuemroRighe}`;
        await UPDATE ('VaccinationCenters').with ({availableVaccines : tot_vacc - req.data.asingedVaccines});
    })*/

})