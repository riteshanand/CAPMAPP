module.exports = (srv) => {

    srv.on('helloWorld', (req) => {
        return "Hello" + req.data.name;
    });
    srv.on('calcRadius', (req) => {
        return 3.14 * req.data.radius * req.data.radius;
    })

    srv.on('READ', "ReadEmployeeSrv", async (req, res) => {
        // return {
        //     "ID": "SPIDERMAN",
        //     "nameFirst": "Abhinav Anand"
        // };

        const { employees } = cds.entities("buss.db.master");
        // Manual extraction of data using cds QL
        const cdsTx = await cds.tx(req);
        const result = await cdsTx.run(SELECT.from(employees).limit(5).where({ salaryAmount: { '>=': 25000 } }).orderBy(employees.nameFirst, 'desc'));
        var myResult = [];
        for (let index = 0; index < result.length; index++) {
            const element = result[index];
            myResult.push({
                nameFirst: element.nameFirst + " " + element.nameLast,
                salaryAmount: element.salaryAmount,
                ID: element.ID
            })
        }

        return myResult;
    });

}