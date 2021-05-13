using Vacc_Center as service from '../../srv/cat-service';

/*annotate Vacc_Center.PharamceuticalOrders with @UI : {SelectionFields : [
    ID,
    vaccinesNumber,
    pharmName,
    arrivalDate

], };*/

annotate Vacc_Center.GetBookedVacc with @UI : {LineItem #booked: [
    {
        $Type : 'UI.DataField',
        Value : ID,
        Label : 'Vaccine ID',
    },
    {
        $Type : 'UI.DataField',
        Value : completed,
        Label : 'Done',
    },
    {
        $Type : 'UI.DataField',
        Value : vaccineDate,
        Label : 'Date scheduled',
    },
], 
};

annotate Vacc_Center.VaccinationCenters with @UI : {
    SelectionFields    : [
        ID,
        city,
        status
    ],

    LineItem           : [
        {
            $Type : 'UI.DataField',
            Value : city,
            Label : 'Location'
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'Vaccination center status'
        },
        {
            $Type : 'UI.DataField',
            Value : availableVaccines,
            Label : 'Available vaccines'
        },
        {
            $Type : 'UI.DataField',
            Value : recomendedVaccines,
            Label : 'Recommended vaccines assingment'
        },
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'Vacc_Center.EntityContainer/calculateRaccomandedVaccine',
            Label  : 'Calculate racommended vaccines',
        }
    ],
    HeaderFacets       : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#header',
    }, ],
    HeaderInfo         : {
        $Type          : 'UI.HeaderInfoType',
        TypeName       : 'Vaccination center',
        TypeNamePlural : 'Vaccination centers',
        Title          : {
            $Type : 'UI.DataField',
            Value : city,
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : ID,
        },
    },
    FieldGroup #header : {
        $Type : 'UI.FieldGroupType',
        Data  : [{
            $Type : 'UI.DataField',
            Value : sortingCenter.availableVaccines,
            Label : 'Sorting center available vaccines'
        }, ]
    },
    FieldGroup #detail : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : city,
                Label : 'Location'
            },
            {
                $Type : 'UI.DataField',
                Value : status,
                Label : 'Vaccination Center Status'
            },
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'Vaccination Center ID'
            },
            {
                $Type : 'UI.DataField',
                Value : recomendedVaccines,
                Label : 'Recomended Vaccines assignment'
            },
            {
                $Type : 'UI.DataField',
                Value : rt,
                Label : 'RT index value'
            },
            {
                $Type : 'UI.DataField',
                Value : bookedVaccines,
                Label : 'Number of booked vaccines'
            },
            {
                $Type : 'UI.DataField',
                Value : availableVaccines,
                Label : 'Number of available vaccines'
            },
            {
                $Type  : 'UI.DataFieldForAction',
                Action : 'Vacc_Center.EntityContainer/updateVaccCenterVaccines',
                Label  : 'Assing vaccines',
            },

        ],
    },
    Facets             : [
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#detail',
            Label  : 'Vaccination center details',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : 'bookedVaccineAssoc/@UI.LineItem#booked',
            Label  : 'Booked vaccines',
        },

    ],

};
