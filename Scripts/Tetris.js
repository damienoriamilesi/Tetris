// Generated by CoffeeScript 1.6.3
(function() {
  var DrawAll, GetChar, context, current, elements, grid, play, scene,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  scene = null;

  context = null;

  elements = [];

  grid = {
    draw: function() {
      var i, _i, _j, _results;
      context.beginPath();
      for (i = _i = 0; _i <= 300; i = _i += 15) {
        context.moveTo(i, 0);
        context.lineTo(i, 600);
        context.stroke();
      }
      _results = [];
      for (i = _j = 0; _j <= 600; i = _j += 15) {
        context.moveTo(0, i);
        context.lineTo(300, i);
        _results.push(context.stroke());
      }
      return _results;
    }
  };

  current = {
    x: 45,
    y: -15,
    draw: function() {
      context.beginPath();
      context.rect(this.x + 1, this.y + 1, 13, 13);
      context.fillStyle = 'yellow';
      return context.fill();
    }
  };

  window.onload = function() {
    scene = document.getElementById('gameScene');
    context = scene.getContext('2d');
    return setInterval(play, 60);
  };

  DrawAll = function() {
    var element, _i, _len, _results,
      _this = this;
    context.clearRect(0, 0, scene.width, scene.height);
    grid.draw();
    current.draw();
    _results = [];
    for (_i = 0, _len = elements.length; _i < _len; _i++) {
      element = elements[_i];
      _results.push((function() {
        context.beginPath();
        context.rect(element.x + 1, element.y + 1, 13, 13);
        context.fillStyle = 'yellow';
        return context.fill();
      })());
    }
    return _results;
  };

  play = function() {
    if (current.y < 585) {
      current.y = current.y + 15;
      if (current.y === 585) {
        elements.push({
          x: current.x,
          y: current.y
        });
        current.y = 0;
      }
    }
    DrawAll();
    return console.log(current.x);
  };

  document.onkeydown = function(t) {
    if (t.keyCode === 37 && current.x >= 15) {
      current.x = current.x - 15;
    }
    if (t.keyCode === 39 && current.x < 285) {
      current.x = current.x + 15;
    }
  };

  GetChar = function(event) {
    if (__indexOf.call(event, 'which') >= 0) {
      return event.which;
    } else {
      return event.keyCode;
    }
  };

}).call(this);

/*
//@ sourceMappingURL=Tetris.map
*/
