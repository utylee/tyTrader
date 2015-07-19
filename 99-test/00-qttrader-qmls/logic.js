var startComponent;
var startPage;

var goodWordComponent;
var goodWordPage1;

var initPageComponent;
var initPage;

function loadStartPage() {
    startComponent = Qt.createComponent("StartPage.qml");
    if(startComponent.status === Component.Ready)
    {
        console.log("Creating Component StartPage.qml successfully");
        startPage = startComponent.createObject(fullWindow, {});
        if(startPage === null)
        {
            console.log("Error creating startPage Object");
        }
    }
    else if (startComponent.status === Component.Error) {
        console.log("Error loading Component StartPage.qml")
    }
    //component.statusChanged.connnect(loadGoodWordPage2);
    //startPage = startComponent.createObject(fullWindow);
}

function loadGoodWordPage(page) {
    console.log("startPage.destroying..")
    //startComponent.statusChanged.connnect(loadGoodWordPage2);
    //startPage.statusChanged.connect(loadGoodWordPage2);
    //startPg.destruction.connect(loadGoodWordPage2);
    //startPg.destroy(1000);
    //startPg.opacity = 0;
    //startPage.destroy();
    page.destroy();

    console.log("startPage.destroy() called");
    goodWordComponent = Qt.createComponent("GoodWordPage.qml");
    console.log("Qt.createComponent(GoodWordPage.qml) - ", goodWordComponent);

    goodWordPage1 = goodWordComponent.createObject(fullWindow, {});
    console.log("goodWordComponent.createObject(fullWindow) - ", goodWordPage1);
}

function loadGoodWordPage2() {
    console.log("came into loadGoodWordPage2()");

    if(startComponent.status === Component.Null)
    {
        console.log("destroy confirmed: StartPage")
        goodWordComponent = Qt.createComponent("GoodWordPage.qml");
        goodWordPage1 = goodWordComponent.createObject(fullWindow);
    }
}

function gotoInitPage(page) {
    //goodWordComponent.statusChanged.connect(gotoInitPage2);
    console.log("goodWordPg.destroy();");
    //goodWordPg.destroy();
    page.destroy();
    //goodWordPg.opacity = 0;

    //console.log("goodWordPg destroyed.. loading AdvisorInitPage.qml")
    initPageComponent = Qt.createComponent("AdvisorInitPage.qml");
    console.log("Qt.createComponent AdvisorInitPage.qml");
    initPage = initPageComponent.createObject(fullWindow);

}

function gotoInitPage2() {
    if(goodWordComponent.status === Component.Null)
    {
        console.log("destroy confirmed: goodWordPg ")
        initPageComponent = Qt.createComponent("AdvisorInitPage.qml");
        console.log("creating advisorPage..")
        initPage = initPageComponent.createObject(fullWindow);
    }
}

function endOfIntro() {
    console.log("adInitpg.outAnim.start()");
    //adInitpg.outAnim.start();

    //adInitpg.destroy(1000);
    //goodWordPage.start();

}

//Qt.createComponent("AdvisorInitPage.qml");

