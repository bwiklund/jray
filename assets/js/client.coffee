angular.module 'jray', []


.controller 'MainCtrl', ($scope,$timeout) ->

  instrumenter = new Instrumenter

  fnStr = """
var instrumentedFn = function () {
  var foo = 0;
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if( Math.random() > 0.1 ){
    return;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if( Math.random() > 0.5 ){
    return;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo += 1;
  }
  if (Math.random() > 0.5) {
    foo = 1;
  }

  if( foo >= 4 ){
    doSomethingDumb();
  } else {
    doSomethingEquallyDumb();
  }

  doSomethingTotallyStupid();
}

function doSomethingDumb(){
  var a = 10;
  a += 5;
  a -= 5;
}

function doSomethingEquallyDumb(){
  var a = 10;
  a += 5;
  a -= 5;
  a += 5;
  a -= 5;
}

function doSomethingTotallyStupid(){
  var a = 1337;
}
  """

  # fnStr = "var instrumentedFn = " + dumbFunction.toString()
  changed = instrumenter.instrumentSync fnStr, 'filename.js'
  eval changed

  console.log __cov_1

  linesHit = null
  linesHitFade = []

  update = ->
    linesHit = []
    instrumentedFn()
    $timeout update
    cov = __cov_1
    for k,v of cov.s
      if v > 0
        line = cov.statementMap[k].start.line
        linesHit[ line ] = true
        linesHitFade[ line ] ?= 0
        linesHitFade[ line ] += v
      cov.s[k] = 0 # reset counter
    $scope.cov = cov

    for k,v of linesHitFade
      linesHitFade[k] *= 0.95

  update()

  $scope.fnStr = fnStr
  $scope.fnLines = fnStr.split /\n/

  $scope.lineStyle = (i) ->
    # if linesHit[i+1]
      # background: '#d79c4f'
    if linesHitFade[i+1]
      intensity = Math.sqrt linesHitFade[i+1]
      background: "hsla(205,50%,#{intensity*15}%,1.0)"
    else
      background: '#000'



