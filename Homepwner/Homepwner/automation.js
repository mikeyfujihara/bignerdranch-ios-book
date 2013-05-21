#import "item_name.js"

var target = UIATarget.localTarget();

var names=[];

for (var i=0;i<3;i++) {
	names[i] = randomName();
}
for (var i=0; i<names.length; i++) {
	target.frontMostApp().navigationBar().rightButton().tap();
	target.frontMostApp().mainWindow().buttons()["Type: None"].tap();
	target.frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Furniture"].tap();
	target.frontMostApp().mainWindow().textFields()[0].tap();
	target.frontMostApp().keyboard().typeString(names[i]);
	target.frontMostApp().mainWindow().textFields()[2].tap();
	target.frontMostApp().keyboard().keys()["Delete"].tap();
	target.frontMostApp().keyboard().typeString("33333");
	target.frontMostApp().navigationBar().rightButton().tap();
}