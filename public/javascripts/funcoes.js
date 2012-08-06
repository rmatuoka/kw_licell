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

function Services(){
    $("#servicos").hide();
//	$("#botao").addClass("closed");  
	
	$("#botao2").click(function(){
		if($("#botao2").hasClass("closed"))
		{
		  $("#servicos").slideDown();
		  $("#botao2").removeClass("closed");
		  $("#botao2").addClass("open");
		}
		else
		{
			$("#servicos").slideUp();
			$("#botao2").removeClass("open");
		  	$("#botao2").addClass("closed");
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
        'height'    : 330,
        'centerOnScroll' : true
    });
}

function Abas()
{
	jQuery('.mycarousel').jcarousel();
	$('#conteudo').hide();
		var noticia;	
		var hash = window.location.hash;
		if (hash !='')
		{
			noticia = $(hash).html();
			$('.abas li a[href="' + hash + '"]').parent().addClass('ativo');		
		} else {
			noticia = $('#conteudo div:first-child').html();			
			$('.abas li:first-child').addClass('ativo');		
		}
		$('#noticia').append('<div>' + noticia + '</div>').find('div').slideDown();
		$('.abas li a').click(function(){
			$('.abas li').removeClass('ativo');
			$(this).parent().addClass('ativo');
			var ancora = $(this).attr('href');
			var nome = ancora.substr(1, ancora.length);
			noticia = $('#conteudo div[id="' + nome + '"]').html();
			$('#noticia').empty();
			$('#noticia').append('<div>' + noticia + '</div>').find('div').slideDown();
		return false();
	});
}
function CycleInit()
{
	$('#s4')
		.before('<div id="nav">')
		.cycle({
			fx:     'turnLeft',
			speed:  'fast',
			timeout: 5000,
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

function check_text_onfocus(obj)
{	
    if(obj.value == obj.defaultValue)
        obj.value = '';
}
function check_text_onblur(obj)
{
    if(obj.value=='')
        obj.value = obj.defaultValue;
}
