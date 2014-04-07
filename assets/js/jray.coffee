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
          @linesHitFade[k] *= 0.5



.controller 'MainCtrl', ($scope,$timeout,Inspector,testFn1,testFn2,testFn3,testFn4) ->

  $scope.inspectors = [
    new Inspector "primes1.js", testFn3
    new Inspector "primes2.js", testFn4
    new Inspector "foo.js", testFn1
    new Inspector "bar.js", testFn2
  ]

  update = ->
    window.foobar()
    inspector.update() for inspector in $scope.inspectors
    $timeout update, 50

  update()

  $scope.lineStyle = (inspector,i) ->
    i += 1 # coverage report is 1 indexed
    if inspector.linesHitFade[i]?
      intensity = Math.sqrt inspector.linesHitFade[i]
      value = ~~(intensity*15)
      background: "hsla(205,50%,#{value}%,1.0)"
      color: if value > 100 then 'black' else 'white'
    else
      background: '#000'
      color: 'white'

  $scope.currentScriptIndex = 0
  $scope.focusOnScript = (i) ->
    $scope.currentScriptIndex = i

  $scope.doSomething = ->
    window.erasthenes(100000)



window.onload = ->
  el = angular.element "<div ng-include src=\"'jray.html'\"></div>"
  document.body.appendChild el[0]
  angular.bootstrap el, ['jray']
