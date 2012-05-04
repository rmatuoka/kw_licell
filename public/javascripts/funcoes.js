$(document).ready(function() {
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
	
	$("#tabs").tabs();
	
});

