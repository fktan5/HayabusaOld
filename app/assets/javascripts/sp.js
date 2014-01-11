$(function(){
	$("#linkmenu div").on("click", function(){
		$(this).next().slideToggle();
		//$(this).next().toggleClass("active");
	});
});
