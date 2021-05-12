namespace vaccination.center;

using {cuid} from '@sap/cds/common';


entity VaccinationCenters : cuid {
    status             : String;
    city               : String;
    rt                 : Double;
    recomendedVaccines : Integer;
    availableVaccines  : Integer;
    sortingCenter      : Association to SortingCenters;
    bookedVaccineAssoc : Association to many BookedVaccines
                             on bookedVaccineAssoc.vaccinationCenter = $self;

}

entity SortingCenters : cuid {
    availableVaccines        : Integer;
    vaccinationCenterAssoc   : Association to many VaccinationCenters
                                   on vaccinationCenterAssoc.sortingCenter = $self;
    pharamceuticalOrderAssoc : Association to many PharamceuticalOrders
                                   on pharamceuticalOrderAssoc.sortingCenter = $self;
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


