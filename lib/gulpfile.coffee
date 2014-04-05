gulp   = require 'gulp'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'
stylus = require 'gulp-stylus'
ngmin  = require 'gulp-ngmin'

paths =
  dest:    './public/build/'
  scripts: ['./assets/js/app.coffee','./assets/js/**/*.coffee']
  sheets:  ['./assets/css/*.styl']

gulp.task 'dev', -> ['watch','server']

gulp.task 'prod', ->

gulp.task 'server', ->
  require './app'

gulp.task 'js', ->
  gulp
    .src  paths.scripts
    .pipe coffee() #.on('error',gutil.log)
    .pipe concat 'all.min.js'
    .pipe ngmin()
    .pipe uglify()
    .pipe gulp.dest paths.dest

gulp.task 'css', ->
  gulp
    .src  paths.sheets
    .pipe stylus set: ['compress']
    .pipe gulp.dest paths.dest

gulp.task 'watch', ->
  gulp.watch paths.scripts, ['js']
  gulp.watch paths.sheets, ['css']

gulp.task 'start', ['default','watch']

gulp.task 'default', ['js','css']
