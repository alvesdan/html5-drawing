<?php
$isiPad = (bool) strpos($_SERVER['HTTP_USER_AGENT'],'iPad');
if (!$isiPad) header("Location: noiPad.php");
$draw = (isset($_GET['draw'])) ? $_GET['draw'] : 'draw1.png';
if ( ! file_exists("draws/{$draw}")) { $draw = 'draw1.png'; }
?><!DOCTYPE HTML> 
<html> 
	<head>
		<title>iPad Draw</title> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /> 
		<link href="css/style.css" media="screen" rel="stylesheet" type="text/css" />
		<style type="text/css">
			#draw { background: url(draws/<?php echo $draw; ?>) transparent no-repeat left top; }
		</style>
		<script type="text/javascript">
			var drawURL = "<?php echo $draw; ?>";
		</script>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/draw.js"></script>
	</head> 
	<body>
		
		<canvas id="can"></canvas>
		<div id="draw">&nbsp;</div>
		
		<div class="tools">
			<ul class="colors">
				<li class="color0 active">&nbsp;</li>
				<li class="color1">&nbsp;</li>
				<li class="color2">&nbsp;</li>
				<li class="color3">&nbsp;</li>
				<li class="color4">&nbsp;</li>
				<li class="color5">&nbsp;</li>
				<li class="color6">&nbsp;</li>
				<li class="color7">&nbsp;</li>
				<li class="color8">Eraser</li>
			</ul>
			<ul class="pencils">
				<li>5</li>
				<li class="active">15</li>
				<li>25</li>
				<li>35</li>
			</ul>
		</div>
		
		<div class="clear button">Clear</div>
		<div class="gallery button">Gallery</div>
		<div class="save button">Share</div>
		<div class="share">
			<div class="close">X</div>
			<div class="content">&nbsp;</div>
		</div>
		
		<div class="moldure">
			&nbsp;
		</div>
		
	</body>
</html> 