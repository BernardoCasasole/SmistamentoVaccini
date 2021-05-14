using vaccination.center as my from '../db/data-model';

service Vacc_Center {
    entity VaccinationCenters as select from my.VaccinationCenters{
        ID, city, status, recomendedVaccines, availableVaccines, rt, bookedVaccines, sortingCenter, bookedVaccineAssoc
        };

    action calculateRaccomandedVaccine() returns Integer; 

    action updateVaccCenterVaccines(asingedVaccines:Integer,id_vacc_center:String) returns Integer;

    //action getVaccinesTodo(vacc_center_id:String);

    entity Vacc_Center_details as select from my.VaccinationCenters{
    ID, city, status, recomendedVaccines, availableVaccines, rt
    };

    entity Vacc_available_sorting_center as select from my.SortingCenters{
        ID, availableVaccines
    };

    @odata.draft.enabled
    entity PharamceuticalOrders as select from my.PharamceuticalOrders;

    entity GetBookedVacc as select from my.BookedVaccines{
         ID, vaccinationCenter, vaccineDate, completed
    };

}