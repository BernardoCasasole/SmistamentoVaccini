using vaccination.center as my from '../db/data-model';

service Vacc_Center {
    entity VaccinationCenters as select from my.VaccinationCenters{
        ID, city, status, recomendedVaccines, availableVaccines
        };
    action calculateRaccomandedVaccine(num_booked:Integer,rt:Double) returns Integer; 
}

service Vacc_Center_details {
    entity VaccinationCenters as select from my.VaccinationCenters{
        ID, city, status, recomendedVaccines, availableVaccines, rt
        }
}

service Vacc_available_sorting_center {
    entity SortingCenters as select from my.SortingCenters{
        ID, availableVaccines
    }
}

service Orders {
    entity PharamceuticalOrders as select from my.PharamceuticalOrders 
}

// todo --> chiedere
service Booked_Vacc {
    entity BookedVaccines as select from my.BookedVaccines 
}

//-------actions------------