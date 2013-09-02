context  = null
canvas = null
gridMaxX = 16
gridMaxY = 30
current = null
showGrid = 0

templates = [{color:"red",name:"cube", path:[{x:0,y :0},{x:1,y:0},{x:0,y:1},{x:1,y:1}]}, #cube
             {color:"yellow",name:"line", path:[{x:0,y :0},{x:0,y:1},{x:0,y:2},{x:0,y:3}]}, #line
             {color:"blue",name:"L", path:[{x:0,y :0},{x:0,y:1},{x:0,y:2},{x:1,y:2}]},#L
             {color:"pink",name:"otherL", path:[{x:0,y :0},{x:0,y:1},{x:0,y:2},{x:-1,y:2}]},# the other L
             {color:"grey",name:"S", path:[{x:0,y :0},{x:1,y:0},{x:1,y:1},{x:2,y:1}]},#s
             {color:"black",name:"otherS", path:[{x:0,y :0},{x:-1,y:0},{x:-1,y:1},{x:-2,y:1}]},# the other s
             {color:"orange",name:"T", path:[{x:0,y :0},{x:1,y:0},{x:0,y:1},{x:0,y:-1}]}]# T

rotateLeft = (path) ->
  for point in path
    x = point.y
    y = -point.x
    point.x = x
    point.y = y
  path

grid =
{
  occuped:[]
  drawColumn : ->
    if showGrid == 1
      context.beginPath()
      for i in [0..gridMaxX] by 1
        context.moveTo i * 15,0
        context.lineTo i * 15,gridMaxY * 15
        context.stroke()
      for i in [0..gridMaxY] by 1
        context.moveTo 0,i * 15
        context.lineTo gridMaxX * 15,i * 15
        context.stroke()
}

getNewBlock = ->
  template = Math.floor(Math.random() * 6)
  console.log template
  current = {
    x : gridMaxX / 2
    y : -1
    template : templates[template]
  }
  return

window.onload = ->
  canvas = document.createElement 'canvas'
  canvas.width = gridMaxX * 15
  canvas.height = gridMaxY * 15
  canvas.style.backgroundColor = "yellowgreen"
  document.body.appendChild canvas
  context = canvas.getContext '2d'
  getNewBlock()
  setInterval play , 100

draw = ->
  context.clearRect(0, 0, canvas.width, canvas.height);
  grid.drawColumn()
  drawElement current
  drawElement element for element in grid.occuped
  return

drawElement = (element) ->
  if element.x? and element.y?
    if element.color?
      drawElementItem(element.x,element.y,element.color)
    if element.template? and element.template.path?
      drawElementItem(element.x + item.x,element.y + item.y,element.template.color) for item in element.template.path
  return

drawElementItem = (x,y,color) ->
  context.beginPath()
  context.rect (x * 15) + 1, (y * 15) + 1, 13, 13
  context.fillStyle = color;
  context.fill()

play = ->
  moveDown(current)
  draw()
  return

updateGrid = (element) ->
  grid.occuped.push (x:element.x + item.x,y:element.y + item.y,color:element.template.color) for item in element.template.path
  #Remove full lines
  for currentLine in [0..gridMaxY]
    dummy = 'I am useless but my poor developper still doesn\'t know how to do it better way'
    liste = (dummy for state in grid.occuped when currentLine == state.y )
    if liste.length == gridMaxX
      grid.occuped = grid.occuped.filter (item) -> item.y isnt currentLine
      for item in grid.occuped when item.y < currentLine
        do =>
          item.y += 1
  console.log fullLines.length
  return

moveDown = (element) ->
    canMove = move(element,0,1)
    unless canMove
      updateGrid(current)
      getNewBlock()

#check still in the grid ans nothing on the way
checkItem = (x,y) ->
  dummy = 'I am useless but my poor developper doesn\'t know how to do it better way'  #maybe a better way, but i'm a noob in coffee
  if y < gridMaxY and x >= 0 and x < gridMaxX #still in the grid
    list = (dummy for state in grid.occuped when x == state.x and y == state.y )
    if list.length == 0 #nothing's already there
      return true
  return false

move = (element,x,y) ->
  canMove = true
  for item in element.template.path
    do =>
      unless checkItem(element.x + item.x + x,element.y + item.y + y)
        canMove = false
      return
  if canMove
    current.x += x
    current.y += y
  return canMove

#rotate = (element) ->

document.onkeydown = (t) ->
  if t.keyCode == 37
    move(current,-1,0)
  if t.keyCode == 39
    move(current,1,0)
  if t.keyCode == 40
    move(current,0,1)
  if t.keyCode == 32
    rotate(current)
  return

