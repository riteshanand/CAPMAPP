namespace buss.srv;

using {
    buss.db.master as master,
    buss.db.transaction as transaction
} from '../db/datamodel';

using {buss.view as cdsView} from '../db/CDSViews';


service CatalogService @(
    path    : 'CatalogService',
    requires: 'authenticated-user'
) {
    //End Point to perform the CRUDQ operations.

    // @Capabilities: {
    //     Updatable: false,
    //     Deletable: true
    // }
    // @readonly
    entity EmployeeSet @(restrict: [
        {
            grant: ['READ'],
            to   : 'Viewer',
            where: 'bankName = $user.BankName'
        },
        {
            grant: ['WRITE'],
            to   : 'Admin'
        }
    ])                                      as projection on master.employees;

    @Capabilities: {
        Updatable: false,
        Deletable: false
    }
    entity BusinessPartnerSet               as projection on master.businesspartner;

    entity AddressSet                       as projection on master.address;
    entity ProductSet                       as projection on master.product; //commenting as the product data is already targetted by the cdsview projection
    // entity POItems                          as projection on transaction.poitems;

    // datamodel_transaction
    entity POs @(odata.draft.enabled: true) as
        projection on transaction.purchaseorder {
            *,
            round(GROSS_AMOUNT) as GROSS_AMOUNT  : Decimal(10, 2),
            case OVERALL_STATUS
                when
                    'N'
                then
                    'New'
                when
                    'P'
                then
                    'Pending'
                when
                    'D'
                then
                    'Delivered'
                when
                    'A'
                then
                    'Approved'
                when
                    'X'
                then
                    'Rejected'
            end                 as OverallStatus : String(10),
            case OVERALL_STATUS
                when
                    'N'
                then
                    2
                when
                    'P'
                then
                    2
                when
                    'D'
                then
                    3
                when
                    'A'
                then
                    3
                when
                    'X'
                then
                    1
            end                 as Criticality   : Integer,

            Items                                : redirected to POItems
        }
        actions {
            //definition
            @cds.odata.bindingparameter.name: '_anubhav'
            @Common.SideEffects             : {TargetProperties: ['_anubhav/GROSS_AMOUNT']}
            action   boost();
            function largestOrder() returns array of POs;
        };

    entity POItems                          as projection on transaction.poitems;


//CDSView

// entity ProductView as projection on cdsView.CDSViews.ProductView{
//     *,
//     To_Items
// };
// entity POItems as projection on cdsView.CDSViews.ItemView;

// entity CProductValuesView as projection on cdsView.CDSViews.CProductValuesView;

// entity employeesSetView                 as projection on cdsView.CDSViews.employees;
}
