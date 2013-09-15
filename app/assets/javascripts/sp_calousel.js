$(document).ready(function(){
	var carouFredProperty = new Object();
	carouFredProperty.swipe = true;
	carouFredProperty.auto = false;
	//carouFredProperty.height = 300px;
	carouFredProperty.prev = ".carouPrev";
	carouFredProperty.next = ".carouNext";
	$("#site_carousel").carouFredSel(carouFredProperty);
});
