angular.module 'jray', []



.factory 'Inspector', ->
  class Inspector
    constructor: (@fnStr) ->
      @fnLines = @fnStr.split /\n/
      @linesHit = []
      @linesHitFade = []

      instrumenter = new Instrumenter
      instrumentedFnStr = instrumenter.instrumentSync fnStr, 'filename.js'
      
      # evaluate the script in the global scope
      eval.call window, instrumentedFnStr
      @cov = window[ instrumenter.currentState.trackerVar ]

      # defined in this closure until i think of a more clever way
      # to handle scope in the instrumented script.
      @update = ->
        @linesHit = []
        window.instrumentedFn()
        for k,v of @cov.s
          if v > 0
            line = @cov.statementMap[k].start.line
            @linesHit[ line ] = true
            @linesHitFade[ line ] ?= 0
            @linesHitFade[ line ] += v
          @cov.s[k] = 0 # reset counter

        for k,v of @linesHitFade
          @linesHitFade[k] *= 0.95



.controller 'MainCtrl', ($scope,$timeout,Inspector,testFn) ->

  $scope.inspector = new Inspector testFn

  update = ->
    $scope.inspector.update()
    $timeout update

  update()

  $scope.lineStyle = (i) ->
    i += 1 # coverage report is 1 indexed
    if $scope.inspector.linesHitFade[i]?
      intensity = Math.sqrt $scope.inspector.linesHitFade[i]
      background: "hsla(205,50%,#{~~(intensity*15)}%,1.0)"
    else
      background: '#000'



