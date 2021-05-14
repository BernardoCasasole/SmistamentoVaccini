using Vacc_Center as service from '../../srv/cat-service';

annotate Vacc_Center.PharamceuticalOrders with {
    ID @UI.Hidden
}


annotate Vacc_Center.PharamceuticalOrders with @UI : {
    SelectionFields    : [
        ID,
        pharmName,
        sortingCenter_ID

    ],

    LineItem           : [
        {
            $Type : 'UI.DataField',
            Value : pharmName,
            Label : 'Pharmaceutical provider name'
        },
        {
            $Type : 'UI.DataField',
            Value : vaccinesNumber,
            Label : 'Number of vaccines ordered'
        },
        {
            $Type : 'UI.DataField',
            Value : arrivalDate,
            Label : 'Arrival date'
        }
    ],
    HeaderInfo         : {
        $Type          : 'UI.HeaderInfoType',
        TypeName       : 'Pharmaceutical Order',
        TypeNamePlural : 'Pharmaceutical Order',
        Title          : {
            $Type : 'UI.DataField',
            Value : pharmName,
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : ID,
        },
    },
    FieldGroup #detail : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : pharmName,
                Label : 'Pharmaceutical provider name'
            },
            {
                $Type : 'UI.DataField',
                Value : vaccinesNumber,
                Label : 'Number of vaccines ordered'
            },
            {
                $Type : 'UI.DataField',
                Value : arrivalDate,
                Label : 'Arrival date'
            },

            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'Order ID'
            },
            {
                $Type : 'UI.DataField',
                Value : sortingCenter_ID,
                Label : 'Destination ID'
            },
            {
                $Type : 'UI.DataField',
                Value : 'No delay',
                Label : 'Delay'
            }
        ],
    },
    Facets             : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#detail',
        Label  : 'Vaccination center details',

    }

    ],

};
