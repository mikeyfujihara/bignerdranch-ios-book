function randomName(){
	adjs = ['Rusty', 'Fluffy', 'Shiny'];
	nouns = ['television', 'spork', 'car'];
	name = adjs[Math.floor(Math.random() * adjs.length)] + " " + nouns[Math.floor(Math.random() * nouns.length)];
	return name;
}