context  = null
canvas = null
gridMaxX = 10
gridMaxY = 40
current = null
showGrid = 0

cubeTemplate = {
  color:"red",
  path:[]
}
cubeTemplate.path.push {
  x: 0,
  y :0
}
cubeTemplate.path.push {
  x: 1,
  y :0
}
cubeTemplate.path.push {
  x:0,
  y:1
}
cubeTemplate.path.push {
  x:1,
  y:1
}

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
  current = {
    x : gridMaxX / 2
    y : -1
    template : cubeTemplate
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
  return

moveDown = (element) ->
    canMove = move(element,0,1)
    unless canMove
      updateGrid(current)
      getNewBlock()

#check still in the grid ans nothing on the way
checkItem = (x,y) ->
  dummy = 'found'  #maybe a better way, but i'm a noob in coffee
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

document.onkeydown = (t) ->
  if t.keyCode == 37
      move(current,-1,0)
  if t.keyCode == 39
      move(current,1,0)

  return

GetChar = (event) ->
  if 'which' in event
    event.which
   else
    event.keyCode;




