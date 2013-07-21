$(document).ready(function(){
	
	var winWidth = $(window).width();
	var winHeight = $(window).height();
	
	$("#can").attr('width', 975);
	$("#can").attr('height', 588);
	$("#draw").width(975).height(588);
	
	var draw = false;
	var canvas = document.getElementById("can");
	var myDraw = document.getElementById("draw");
	var ctx = canvas.getContext("2d");
	ctx.strokeStyle = '#333333';
	ctx.lineWidth = 15;
	var x , y, xOffset, yOffset, textX, textY;
	var textTool = false;
	var points = [];
	var start;
	ctx.fillStyle = "rgba(255, 255, 255, 1)";
	ctx.fillRect (0, 0, 975, 588);
	xOffset = 0;
	yOffset = 0;
	
	myDraw.addEventListener('touchstart', function(event){
		x = event.touches[0].pageX - 24;
		y = event.touches[0].pageY - yOffset - 23;
		draw = true;
		points.push([x, y]);
		event.preventDefault();
	});
	
	myDraw.addEventListener('touchend', function(){
		draw = false;
		points = [];
	});
	
	myDraw.addEventListener('touchmove', touchMove);
	
	function touchMove(event){
		var point = [event.touches[0].pageX - xOffset - 24, event.touches[0].pageY - yOffset - 23];	
		points.push(point);
		event.preventDefault();
	}
	
	setInterval(function() {
		
		var start;
		
		if ( ! (points.length))
		{
			return null;
		}
		
		start = new Date();
		
		if(draw)
		{
			ctx.beginPath();
			while(points.length && new Date() - start < 10)
			{
				drawLine(points.shift());	
			}
			
			return ctx.stroke();
		}
		
	}, 30);
	
	function drawLine(point)
	{
		ctx.lineCap = "round";
		ctx.moveTo(x, y);
		x = point[0];
		y = point[1];
		return ctx.lineTo(x, y);
	}
	
	$(".pencils li").click(function(){
		var width = $(this).html();
		ctx.lineWidth = width;
		clearMarkPencils();
		$(this).addClass('active');
	});
	
	$(".colors li").click(function(){
		var color = $(this).css('background-color');
		ctx.strokeStyle = color;
		clearMark();
		$(this).addClass('active');
	});
	
	function clearMarkPencils()
	{
		$(".pencils li").each(function(){
			$(this).removeClass('active');
		});
	}
	
	function clearMark()
	{
		$(".colors li").each(function(){
			$(this).removeClass('active');
		});
	}
	
	function saveImage()
	{
		var data_post = canvas.toDataURL();
		$.post("save.php", { data: data_post }, function(response){
			
			file_name = response.file_name;
			saved = response.saved;
			
			if (saved == 1)
			{
				$(".share .content").html("You can see your draw here: <a href=\"saved/" + file_name + "\" target=\"_blank\"><img src=\"saved/" + file_name + "\" width=\"200\" /></a><br />Click and hold to save.");
				$(".share").fadeIn();
			}
			
		}, "json");
	}
	
	$('.share .close').click(function(){
		$(".share").fadeOut();
	});
	
	$(".save").click(function(){
		var myImage = new Image();		
		myImage.onload = function()
		{
			ctx.drawImage(myImage, 0, 0, 1024, 673);
			saveImage();
		}
		myImage.src = "draws/" + drawURL;
	});
	
	$(".gallery").click(function(){
		location.href = 'gallery.php';
	});
	
	$(".clear").click(function(){
		ctx.fillStyle = "rgba(255, 255, 255, 1)";
		ctx.fillRect (0, 0, 975, 588);
	});
	
});