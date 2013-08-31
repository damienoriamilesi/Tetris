scene = null
context  = null
elements = []

grid =
{
  draw : ->
    context.beginPath()
    for i in [0..300] by 15
      context.moveTo i,0
      context.lineTo i,600
      context.stroke()

    for i in [0..600] by 15
      context.moveTo 0,i
      context.lineTo 300,i
      context.stroke()
}

current = {
  x : 45
  y : -15
  draw : ->
    context.beginPath()
    context.rect this.x + 1, this.y + 1, 13, 13
    context.fillStyle = 'yellow';
    context.fill()
}

window.onload = ->
  scene = document.getElementById 'gameScene'
  context = scene.getContext '2d'
  setInterval play , 60

DrawAll = ->
  context.clearRect(0, 0, scene.width, scene.height);
  grid.draw()
  current.draw()
  for element in elements then do =>
    context.beginPath()
    context.rect element.x + 1, element.y + 1, 13, 13
    context.fillStyle = 'yellow';
    context.fill()

play = ->
  if current.y < 585
    current.y = current.y + 15
    if current.y == 585
      elements.push
        x : current.x,
        y : current.y
      current.y = 0
  DrawAll()
  console.log current.x

document.onkeydown = (t) ->
  if t.keyCode == 37 && current.x >= 15
      current.x = current.x - 15
  if t.keyCode == 39 && current.x < 285
      current.x = current.x + 15

  return

GetChar = (event) ->
  if 'which' in event
    event.which
   else
    event.keyCode;




