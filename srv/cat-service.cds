using vaccination.center as my from '../db/data-model';

service Vacc_Center {
    entity VaccinationCenters as select from my.VaccinationCenters{
        ID, city, status, recomendedVaccines, availableVaccines
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

    entity PharamceuticalOrders as select from my.PharamceuticalOrders;
}