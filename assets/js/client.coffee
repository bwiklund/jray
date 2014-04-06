angular.module 'jray', []



.factory 'Inspector', ->
  class Inspector
    constructor: (@fnStr) ->
      @fnLines = @fnStr.split /\n/

      instrumenter = new Instrumenter
      changed = instrumenter.instrumentSync fnStr, 'filename.js'
      eval changed
      @cov = __cov_1

      @linesHit = []
      @linesHitFade = []

      # defined in this closure until i think of a more clever way
      # to handle scope in the instrumented script.
      @update = ->
        @linesHit = []
        instrumentedFn()
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



