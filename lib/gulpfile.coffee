gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
uglify  = require 'gulp-uglify'
concat  = require 'gulp-concat'
stylus  = require 'gulp-stylus'
ngmin   = require 'gulp-ngmin'
connect = require 'gulp-connect'
jade    = require 'gulp-jade'

paths =
  dest:    './build'
  scripts: ['./assets/js/app.coffee','./assets/js/**/*.coffee']
  sheets:  ['./assets/css/**/*.styl']
  views:   ['./assets/views/**/*.jade']

gulp.task 'jade', ->
  gulp
    .src  paths.views
    .pipe jade()
    .pipe gulp.dest paths.dest

gulp.task 'js', ->
  gulp
    .src  paths.scripts
    .pipe coffee() #.on('error',gutil.log)
    .pipe concat 'all.min.js'
    .pipe ngmin()
    # .pipe uglify()
    .pipe gulp.dest paths.dest

gulp.task 'css', ->
  gulp
    .src  paths.sheets
    .pipe stylus set: ['compress']
    .pipe gulp.dest paths.dest

gulp.task 'watch', ->
  gulp.watch paths.scripts, ['js']
  gulp.watch paths.sheets, ['css']
  gulp.watch paths.views, ['jade']

gulp.task 'connect', -> connect.server
  root: ['build','static']
  port: 8765

gulp.task 'dev', ['default','connect','watch']

gulp.task 'default', ['js','css','jade']
