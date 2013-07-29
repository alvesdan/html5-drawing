jQuery ->
  is_ipad = navigator.userAgent.match(/iPad/i) != null
  if (is_ipad)
    $("body").addClass("ipad-device")
    