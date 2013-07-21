<?php
$data	= $_POST['data'];
$uri	= substr($data, strpos($data, ",") + 1);
$saved	= 0;

function file_name()
{
	$str = 'abcdefghijklmnopqrstuvxwyzABCDEFGHIJKLMNOPQRSTUXWYXZ1234567890';
	return substr(sha1(str_shuffle($str)), 0, 8).".png";
}

$file_name = file_name();
while (file_exists("saved/$file_name")) { $file_name = file_name(); }
if (file_put_contents("saved/$file_name", base64_decode($uri))) { $saved = 1; }

echo json_encode(array('file_name' => $file_name, 'saved' => $saved));