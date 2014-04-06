angular.module 'jray', []


.controller 'MainCtrl', ($scope,$timeout) ->

  instrumenter = new Instrumenter

  dumbFunction = ->
    for i in [0...100]
      console.log "fart"

  fnStr = "var instrumentedFn = " + dumbFunction.toString()
  changed = instrumenter.instrumentSync fnStr, 'filename.js'
  eval changed

  update = ->
    instrumentedFn()
    $timeout update, 500
    $scope.cov = __cov_1

  update()

  # console.log __cov_1



