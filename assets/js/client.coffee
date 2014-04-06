angular.module 'jray', []


.controller 'MainCtrl', ($scope,$timeout,testFn) ->

  instrumenter = new Instrumenter

  # fnStr = "var instrumentedFn = " + dumbFunction.toString()
  changed = instrumenter.instrumentSync testFn, 'filename.js'
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

  $scope.fnStr = testFn
  $scope.fnLines = testFn.split /\n/

  $scope.lineStyle = (i) ->
    i += 1 # coverage report is 1 indexed
    # if linesHit[i+1]
      # background: '#d79c4f'
    if linesHitFade[i]?
      intensity = Math.sqrt linesHitFade[i]
      background: "hsla(205,50%,#{~~(intensity*15)}%,1.0)"
    else
      background: '#000'



