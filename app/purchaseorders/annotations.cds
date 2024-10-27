using buss.srv.CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    UI.SelectionFields      : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        OVERALL_STATUS

    ],
    UI.LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        // {
        //     $Type : 'UI.DataFieldForAction',
        //     Label : 'Boost',
        //     Action: 'buss.srv.CatalogService.boost',
        //     Inline: true
        // },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type                    : 'UI.DataField',
            Value                    : OverallStatus,
            Criticality              : Criticality,
            CriticalityRepresentation: #WithIcon,

        }
    ],
    UI.HeaderInfo           : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl      : 'https://cdn.pixabay.com/photo/2024/01/15/11/36/batman-8510027_640.png'
    },
    UI.Facets               : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'More Details',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target: '@UI.Identification'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Data',
                    Target: '@UI.FieldGroup#batman'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status Data',
                    Target: '@UI.FieldGroup#spiderman'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'Items/@UI.LineItem',
            Label : 'PO Items'
        }
    ],

    UI.Identification       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
            @title: 'Partner Key'
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: ID
        }

    ],
    UI.FieldGroup #batman   : {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        }
    ]},
    UI.FieldGroup #spiderman: {Data: [
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
        {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS
        }
    ]}

);

annotate service.POItems with @(
    UI.LineItem            : [
        {
            $Type: 'UI.DataField',
            Value: PARENT_KEY_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        }
    ],
    UI.HeaderInfo          : {
        TypeName      : 'Purchase Order Item',
        TypeNamePlural: 'Purchase Order Items',
        Title         : {Value: PO_ITEM_POS},
        Description   : {Value: PRODUCT_GUID.DESCRIPTION},
        ImageUrl      : 'https://cdn.pixabay.com/photo/2024/01/15/11/36/batman-8510027_640.png'
    },
    UI.Facets              : [{
        $Type : 'UI.CollectionFacet',
        Label : 'More Details',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'More Info',
                Target: '@UI.Identification'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Pricing Data',
                Target: '@UI.FieldGroup#ItemData'
            }
        ]
    }],
    UI.Identification      : [
        {
            $Type: 'UI.DataField',
            Value: ID
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS
        }

    ],
    UI.FieldGroup #ItemData: {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        }
    ]}
);

annotate service.POs with {
    PARTNER_GUID @(
        // Common:{
        //     Text : 'PARTNER_GUID.COMPANY_NAME',
        // },
        Common.Text     : PARTNER_GUID.COMPANY_NAME,
        ValueList.entity: service.BusinessPartnerSet
    )
};

annotate service.POItems with {
    PRODUCT_GUID @(
        // Common:{
        //     Text : 'PRODUCT_GUID.DESCRIPTION',
        // },
        Common.Text     : PRODUCT_GUID.DESCRIPTION,
        ValueList.entity: service.ProductSet
    )
};


@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: COMPANY_NAME
}]);

@cds.odata.valuelist
annotate service.ProductSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: DESCRIPTION
}]);
