jQuery ->
  is_ipad = navigator.userAgent.match(/iPad/i) != null
  if (is_ipad)
    $("body").addClass("ipad-device")
  else
    $(".standalone-overlay p").html("Visit this page from your <br /><strong>iPad</strong> device.")
    