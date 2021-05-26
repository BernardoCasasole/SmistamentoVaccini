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

            var available = result[i].availableVaccines

            var righe = await SELECT.from('BookedVaccines').where({ completed: false, vaccinationCenter_ID : result[i].ID});
            var nuemroRighe = righe.length;
            var stat = nuemroRighe - available
            //await UPDATE ('VaccinationCenters',result[i].ID).with ({requiredVaccines: stat});
            if (nuemroRighe < 1){
                await UPDATE ('VaccinationCenters',result[i].ID).with ({status: 'inactive'});
                console.log("\n---------------------------\nInactive\n---------------------------\n");
                return 0;
            }
            amount = Math.round(nuemroRighe * (0.9 + result[i].rt) - available);

            if(stat <= 0 && amount-available > 0){
                await UPDATE ('VaccinationCenters',result[i].ID).with ({status: 'required number satisfied'});
                console.log("\n---------------------------\nNo vaccines needed\n---------------------------\n");
                await UPDATE ('VaccinationCenters',result[i].ID).with ({recomendedVaccines: amount});
                return 0;
            }
            if(amount-available < 0){
                amount = 0;
                await UPDATE ('VaccinationCenters',result[i].ID).with ({status: 'recommended number satisfied'});
                console.log("\n---------------------------\nToo much vaccines\n---------------------------\n");
            }else{
                await UPDATE ('VaccinationCenters',result[i].ID).with ({status: 'vaccines shortage'});
                console.log("\n---------------------------\nVaccines Shortage\n---------------------------\n");
            }

            await UPDATE ('VaccinationCenters',result[i].ID).with ({recomendedVaccines: amount});
           // await UPDATE `vaccination.center.VaccinationCenters`.set `recomendedVaccines = ${amount}`.where `ID = ${ID}`;

        }
        
        return 0;
    })

    this.on("updateVaccCenterVaccines", async function(req){
        var sortingCenter_row = await SELECT.one.from('SortingCenters');
        var tot_vacc = sortingCenter_row.availableVaccines;

        var sortingCenter_row_2 = await SELECT.one.from('VaccinationCenters').where({ID : req.data.id_vacc_center});
        var tot_vacc_2 = sortingCenter_row_2.availableVaccines;

        var tot_vacc_3 = sortingCenter_row_2.recomendedVaccines;
        var tot_vacc_4 = sortingCenter_row_2.requiredVaccines;

        var req_vcc = tot_vacc_4 - req.data.asingedVaccines;
        if(req_vcc < 0){
            req_vcc = 0;
        }
        var recomm_vacc = tot_vacc_3 - req.data.asingedVaccines
        if(recomm_vacc < 0){
            recomm_vacc = 0;
        }

        await UPDATE ('SortingCenters').with ({availableVaccines : tot_vacc - req.data.asingedVaccines});
        await UPDATE ('VaccinationCenters', req.data.id_vacc_center).with ({availableVaccines : tot_vacc_2 + req.data.asingedVaccines});
        await UPDATE ('VaccinationCenters', req.data.id_vacc_center).with ({recomendedVaccines : recomm_vacc});
        await UPDATE ('VaccinationCenters', req.data.id_vacc_center).with ({requiredVaccines : req_vcc});
        
        if(req_vcc > 0){
            await UPDATE ('VaccinationCenters', req.data.id_vacc_center).with ({status : 'vaccines shortage'});
        }
        if(req_vcc == 0 && recomm_vacc > 0){
            await UPDATE ('VaccinationCenters', req.data.id_vacc_center).with ({status : 'required number satisfied'});
        }
        if(req_vcc == 0 && recomm_vacc == 0){
            await UPDATE ('VaccinationCenters', req.data.id_vacc_center).with ({status : 'recommended number satisfied'});
        }

       
        return 0;
    })
    
    this.on("getVaccinesTodo", async function(req){
        var righe = await SELECT.from('BookedVaccines').where({ completed: false, vaccinationCenter_ID: req.data.vacc_center_id});
        var nuemroRighe = righe.length;

        var sortingCenter_row_2 = await SELECT.one.from('VaccinationCenters').where({ID : req.data.vacc_center_id});
        var tot_vacc_2 = sortingCenter_row_2.availableVaccines;
        
        
        req_vacc = nuemroRighe - tot_vacc_2;
        if(req_vacc < 0){
            req_vacc = 0;
        }
        await UPDATE ('VaccinationCenters',req.data.vacc_center_id).with ({requiredVaccines: req_vacc});
        await UPDATE ('VaccinationCenters', req.data.vacc_center_id).with ({bookedVaccines : nuemroRighe});
    })

})