jQuery ->
  is_ipad = navigator.userAgent.match(/iPad/i) != null
  if (!is_ipad)
    $(".standalone-message p").html("Visit this page from your<br /> <strong>iPad</strong> device.")