class Drawing
  constructor: ->
    @canvas = $("#canvas-drawing").get(0)
    @context = @canvas.getContext("2d")
    @context.strokeStyle = "#91c91d"
    @context.lineWidth = 15
    @context.fillStyle = "rgba(255, 255, 255, 1)"
    @context.fillRect(0, 0, 980, 600)
    @x = 0
    @y = 0
    @x_offset = $("#canvas-drawing").offset().left + 20
    @y_offset = $("#canvas-drawing").offset().top + 20
    @points = []
    @allow_drawing = false
    setInterval(@handle_interval, 30)
    @handle_orientation_change()
    
    @canvas.addEventListener "touchstart", (event) =>
      @handle_start(event, event.target)
    
    @canvas.addEventListener "touchmove", (event) =>
      @handle_move(event, event.target)
    
    @canvas.addEventListener "touchend", (event) =>
      @handle_end(event, event.target)
    
    window.addEventListener "orientationchange", (event) =>
      @handle_orientation_change(event)
      
    $(".colors li").click (event) =>
      color = $(event.target).attr("data-color")
      @context.strokeStyle = color
      $(".colors li").removeClass("active")
      $(event.target).addClass("active")
    
    $(".pencils li").click (event) =>
      width = $(event.target).attr("data-size")
      @context.lineWidth = width
      $(".pencils li").removeClass("active")
      $(event.target).addClass("active")
    
    $(".clear-drawing").click (event) =>
     @context.fillStyle = "rgba(255, 255, 255, 1)"
     @context.fillRect(0, 0, 980, 600)
    
    $(".save-image-button").click (event) =>
      event.preventDefault()
      @save_image()
      false
    
    $(".drawings-gallery").click ->
      window.location.href = "/drawings"
  
  handle_start: (event, element) ->
    @x = event.touches[0].clientX - @x_offset
    @y = event.touches[0].clientY - @y_offset
    @points.push([@x, @y])
    @allow_drawing = true
    event.preventDefault()
    
  handle_move: (event, element) ->
    point = [event.touches[0].clientX - @x_offset, event.touches[0].clientY - @y_offset]
    @points.push(point)
    event.preventDefault()
  
  handle_end: (event, element) ->
    @allow_drawing = false
    @points = []
  
  handle_interval: =>
    return null if (!(@points.length))
    start = new Date()
    if (@allow_drawing)
      @context.beginPath()
      while(@points.length && new Date() - start < 10)
        @draw_line(@points.shift())
      @context.stroke()
    
  draw_line: (point) ->
    @context.lineCap = "round"
    @context.moveTo(@x, @y)
    @x = point[0]
    @y = point[1]
    @context.lineTo(@x, @y)
  
  handle_orientation_change: ->
    if (window.orientation == 0 || window.orientation == 180)
      $(".overlay").show()
      $(".wrapper").hide()
      $("ul.colors").hide()
      #$("ul.pencils").hide()
      $("ul.buttons").hide()
    else
      $(".overlay").hide()
      $(".wrapper").show()
      $("ul.colors").show()
      #$("ul.pencils").show()
      $("ul.buttons").show()
  
  save_image: ->
    image = @canvas.toDataURL()
    $(".loading-overlay").css("display", "block")
    $.ajax
      url: "/save",
      type: "post",
      dataType: "json",
      data:
        image_data: image
      success: (data, textStatus, jqXHR) ->
        window.location.href = "/drawings"
      error: (jqXHR, textStatus, errorThrown) ->
        $(".loading-overlay").hide()
    false
      
    
jQuery ->
  if ($(".canvas-wrapper").length)
    drawing = new Drawing()
  if (!window.navigator.standalone)
    $("body").addClass("only-standalone")
    $(".wrapper").remove()
    $(".overlay").remove()