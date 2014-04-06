angular.module 'jray', []


.controller 'MainCtrl', ($scope,$timeout) ->

  instrumenter = new Instrumenter

  dumbFunction = ->
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5
    if Math.random() > 0.5 then foo = 5

  fnStr = "var instrumentedFn = " + dumbFunction.toString()
  changed = instrumenter.instrumentSync fnStr, 'filename.js'
  eval changed

  update = ->
    instrumentedFn()
    $timeout update, 500
    $scope.cov = __cov_1

  update()

  # console.log __cov_1



