namespace vaccination.center;

using {cuid} from '@sap/cds/common';


entity VaccinationCenters : cuid {
    status             : String;
    city               : String;
    rt                 : Double;
    availableVaccines  : Integer;
    sortingCenter      : Association to SortingCenters;
    bookedVaccineAssoc : Association to many BookedVaccines
                             on bookedVaccineAssoc.vaccinationCenter.ID = ID;

}

entity SortingCenters : cuid {
    availableVaccines        : Integer;
    vaccinationCenterAssoc   : Association to many VaccinationCenters
                                   on vaccinationCenterAssoc.sortingCenter.ID = ID;
    pharamceuticalOrderAssoc : Association to many PharamceuticalOrders
                                   on pharamceuticalOrderAssoc.sortingCenter.ID = ID;
}

entity PharamceuticalOrders : cuid {
    vaccinesNumber : Integer;
    pharmName      : String;
    arrivalDate    : Date;
    sortingCenter  : Association to SortingCenters;
}

entity BookedVaccines : cuid {
    vaccinationCenter : Association to VaccinationCenters;
    vaccineDate       : Date;
    completed         : Boolean;
}


