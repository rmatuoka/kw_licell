function CartSlider(){
    $("#Menu").hide();
//	$("#botao").addClass("closed");  
	
	$("#botao").click(function(){
		if($("#botao").hasClass("closed"))
		{
		  $("#Menu").slideDown();
		  $("#botao").removeClass("closed");
		  $("#botao").addClass("open");
		}
		else
		{
			$("#Menu").slideUp();
			$("#botao").removeClass("open");
		  	$("#botao").addClass("closed");
		}
	});
	

	
	 $(".p").mouseover(function() {
      	//alert("a");
	  	$(this).toggleClass("Product_on");
		//alert($(this > "#Buttons"));
		//alert($(this + " .Buttons").html());
    });
	
	$(".p").mouseout(function() {
      	//alert("a");
	  	$(this).toggleClass("Product_on");
		//$(this > ".Buttons").fadeOut("slow");
    });
	
	//$("#tabs").tabs();
}

function Fancyshow()
{
	$('a.iframe').fancybox({
		'width'     : 500,
        'height'    : 320,
        'centerOnScroll' : true
    });
}

function CycleInit()
{
	$('#s4')
		.before('<div id="nav">')
		.cycle({
			fx:     'turnLeft',
			speed:  'fast',
			timeout: 0,
			pager:  '#nav'
	});
}

function ProductsOver()
{
	$('#produtos-bloco > .produto').mouseenter(function(){
		$("#p-des-"+$(this).attr('id')).removeClass('hide');
		$("#p-fot-"+$(this).attr('id')).animate({marginTop: -100});
		$("#p-des-"+$(this).attr('id')).animate({marginTop: -100});
	});
	$('#produtos-bloco > .produto').mouseleave(function(){
		$("#p-fot-"+$(this).attr('id')).animate({marginTop: 0});
		$("#p-des-"+$(this).attr('id')).animate({marginTop: 0});
		$("#p-des-"+$(this).attr('id')).addClass('hide');
	});

}
