const cds = require('@sap/cds');
module.exports = cds.service.impl(async function () {

    // Step 1. Get the Object of oData entities
    const { EmployeeSet, POs } = this.entities;

    this.before(['UPDATE', 'CREATE'], EmployeeSet, (req, res) => {
        console.log("AA GAYA" + req.data.salaryAmount);
        if (parseFloat(req.data.salaryAmount) >= 100000) {
            req.error(500, "Salary must be less than one lakh for any Employee");
        }
    });

     
    this.after(['UPDATE', 'CREATE'], EmployeeSet, (req, res) => {
        console.log("Deke AA GAYA: " + res.data.salaryAmount);
    });

    this.on('boost', async (req, res) => {
        try {
            const ID = req.params[0];
            console.log("Hey you Purchase Order with ID" + ID + "will be boosted");
            const tx = cds.tx(req);
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=': 200000 }
                // NOTE: 'Boosted!!'
            }).where(ID)
        } catch (error) {
            return "Error" + error.toString();
        }

    });

    this.on('largestOrder', async (req, res) => {
        try {
            const ID = req.params[0];
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                // GROSS_AMOUNT: 'desc'
                TAX_AMOUNT: 'asc'
            }).limit(1);

            return reply;

        } catch (error) {
            return "Error" + error.toString();
        }

    });


})