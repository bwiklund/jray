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



.controller 'MainCtrl', ($scope,$timeout,Inspector,ScriptLoader) ->
  console.info "jray:", "Loading scripts..."

  $scope.expanded = true

  $scope.inspectors = []

  new ScriptLoader().loadAll().then (scripts) ->
    for script in scripts
      $scope.inspectors.push new Inspector script.name, script.source

  update = ->
    inspector.update() for inspector in $scope.inspectors
    $timeout update, 50

  update()

  $scope.lineStyle = (inspector,i) ->
    i += 1 # coverage report is 1 indexed
    if inspector.linesHitFade[i]?
      intensity = Math.sqrt inspector.linesHitFade[i]
      value = 100 - ~~(intensity*15)
      value = Math.max( 50, value );
      background: "hsla(10,#{value}%,#{value}%,1.0)"
      # color: if value > 100 then 'white' else 'black'
    else
      background: 'white'
      # color: 'black'

  $scope.currentScriptIndex = 0
  $scope.focusOnScript = (i) ->
    $scope.currentScriptIndex = i

  $scope.toggleExpanded = ->
    $scope.expanded = !$scope.expanded



.factory 'ScriptLoader', ($http,$q) ->
  class ScriptLoader
    constructor: ->

    loadAll: ->
      tags = document.querySelectorAll("script[type='text/jray']")
      promises = for tag in tags
        console.info "jray:", tag.src
        $http.get tag.src

      $q.all(promises).then (scripts) ->
        for script in scripts
          source: script.data
          url: script.config.url
          name: script.config.url.split('/')[-1..][0]


.run (ScriptLoader) ->


window.onload = ->
  el = angular.element "<div ng-include src=\"'jray.html'\"></div>"
  document.body.appendChild el[0]
  angular.bootstrap el, ['jray']
