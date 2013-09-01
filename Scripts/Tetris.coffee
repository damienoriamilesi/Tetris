context  = null
elements = []
canvas = null
gridMaxX = 20
gridMaxY = 40


grid =
{
  draw : ->
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

current = {
  x : gridMaxX / 2
  y : -1
  draw : ->
    context.beginPath()
    context.rect (this.x * 15) + 1, (this.y * 15) + 1, 13, 13
    context.fillStyle = 'yellow';
    context.fill()
    console.log this.x + " - " + this.y
}

window.onload = ->
  canvas = document.createElement 'canvas'
  canvas.width = gridMaxX * 15
  canvas.height = gridMaxY * 15
  canvas.style.backgroundColor = "yellowgreen"
  document.body.appendChild canvas
  context = canvas.getContext '2d'
  setInterval play , 60

DrawAll = ->
  context.clearRect(0, 0, canvas.width, canvas.height);
  grid.draw()
  current.draw()
  for element in elements then do =>
    context.beginPath()
    context.rect (element.x * 15) + 1, (element.y * 15) + 1, 13, 13
    context.fillStyle = 'yellow';
    context.fill()

play = ->
  if current.y < gridMaxY - 1
    current.y += 1
    if current.y == gridMaxY - 1
      elements.push
        x : current.x,
        y : current.y
      current.y = 0
  DrawAll()


document.onkeydown = (t) ->
  if t.keyCode == 37 && current.x >= 1
      current.x = current.x - 1
  if t.keyCode == 39 && current.x < gridMaxX - 1
      current.x = current.x + 1

  return

GetChar = (event) ->
  if 'which' in event
    event.which
   else
    event.keyCode;




