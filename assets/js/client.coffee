angular.module 'jray', []



.factory 'Inspector', ->
  class Inspector
    constructor: (@scriptName,@fnStr) ->
      @fnLines = @fnStr.split /\n/
      @linesHit = []
      @linesHitFade = []

      instrumenter = new Instrumenter
      instrumentedFnStr = instrumenter.instrumentSync @fnStr, @scriptName
      
      # evaluate the script in the global scope
      eval.call window, instrumentedFnStr
      @cov = window[ instrumenter.currentState.trackerVar ]
      # console.log "watching:", instrumenter.currentState.trackerVar

      # defined in this closure until i think of a more clever way
      # to handle scope in the instrumented script.
      @update = ->
        @linesHit = []
        for k,v of @cov.s
          if v > 0
            line = @cov.statementMap[k].start.line
            @linesHit[ line ] = true
            @linesHitFade[ line ] ?= 0
            @linesHitFade[ line ] += v
          @cov.s[k] = 0 # reset counter

        for k,v of @linesHitFade
          @linesHitFade[k] *= 0.95



.controller 'MainCtrl', ($scope,$timeout,Inspector,testFn1,testFn2,testFn3,testFn4) ->

  $scope.inspectors = [
    new Inspector "foo.js", testFn1
    new Inspector "bar.js", testFn2
    new Inspector "primes1.js", testFn3
    new Inspector "primes2.js", testFn4
  ]

  update = ->
    window.instrumentedFn()
    inspector.update() for inspector in $scope.inspectors
    $timeout update

  update()

  $scope.lineStyle = (inspector,i) ->
    i += 1 # coverage report is 1 indexed
    if inspector.linesHitFade[i]?
      intensity = Math.sqrt inspector.linesHitFade[i]
      background: "hsla(205,50%,#{~~(intensity*15)}%,1.0)"
    else
      background: '#000'

  $scope.focusOnScript = (i) ->
    $scope.currentScriptIndex = i

  $scope.currentScriptIndex = 0