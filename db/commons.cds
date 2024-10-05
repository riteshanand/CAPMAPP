namespace buss.common;

using {Currency} from '@sap/cds/common';

type Gender : String(1) enum {
    male        = 'M';
    female      = 'F';
    undisclosed = 'U';
};

type AmountT : Decimal(10, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_code',
    sap.unit                     : 'CURRENCY_code'
);

aspect Amount : {
    CURRENCY     : Currency;
    GROSS_AMOUNT : AmountT @title : '{i18n>GrossAmount}';
    NET_AMOUNT   : AmountT @title : '{i18n>NetAmount}';
    TAX_AMOUNT   : AmountT @title : '{i18n>TaxAmount}';
}

type Guid : String(32);
// type PhoneNumber : String(30)@assert.format:'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
// type Email : String(255)@assert.format : '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
type Email : String(255);
type PhoneNumber : String(30);


