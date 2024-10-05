sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/po/purchaseorders/test/integration/FirstJourney',
		'com/po/purchaseorders/test/integration/pages/POsList',
		'com/po/purchaseorders/test/integration/pages/POsObjectPage',
		'com/po/purchaseorders/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/po/purchaseorders') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);