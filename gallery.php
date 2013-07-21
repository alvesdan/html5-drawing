<?php
$isiPad = (bool) strpos($_SERVER['HTTP_USER_AGENT'],'iPad');
if (!$isiPad) header("Location: noiPad.php");
$files = array();
if ($handle = opendir('saved/')) {
    while (false !== ($file = readdir($handle))) {
        if ($file != "." && $file != ".." && $file != ".DS_Store") {
            $files[] = $file;
        }
    }
    closedir($handle);
}
?><!DOCTYPE HTML>
<html> 
	<head>
		<title>iPad Draw</title> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
		<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /> 
		<link href="css/gallery.css" media="screen" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/lightbox.js"></script>
	    <link rel="stylesheet" type="text/css" href="css/lightbox.css" media="screen" />
		<script type="text/javascript">
			$(function() {
				$('a.lightbox').lightBox({
					imageLoading: 'img/lightbox/lightbox-ico-loading.gif',
					imageBtnClose: 'img/lightbox/lightbox-btn-close.gif',
					imageBtnPrev: 'img/lightbox/lightbox-btn-prev.gif',
					imageBtnNext: 'img/lightbox/lightbox-btn-next.gif',
					containerBorderSize: 1,
					overlayBgColor:'#fff',
					overlayOpacity: 1
				});
			});
		</script>
	</head> 
	<body>
		
		<a href="index.php" class="back button">Back</a>
		<h1>Gallery</h1>
		
		<p style="color:#fff;font-size:18px;text-shadow:0 1px 0 #333;font-weight:bold;">Click and hold to save a draw.</p>
		<br />
		
		<?php if (sizeof($files)){ ?>
			
			<?php foreach($files as $file){ ?>
				
				<ul class="draws">
					<li><a href="saved/<?php echo $file; ?>" class="lightbox"><img src="saved/<?php echo $file; ?>" width="233" /></a></li>
				</ul>
				
			<?php } ?>
			
		<?php } else { ?>
			
			<p>There are no draws saved!</p>
		
		<?php } ?>
		
		<div class="clear-float"></div>
		
	</body>
</html>