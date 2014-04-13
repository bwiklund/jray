gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
uglify  = require 'gulp-uglify'
concat  = require 'gulp-concat'
stylus  = require 'gulp-stylus'
ngmin   = require 'gulp-ngmin'
connect = require 'gulp-connect'
jade    = require 'gulp-jade'
templateCache = require 'gulp-angular-templatecache'
streamqueue = require 'streamqueue'


paths =
  dest:      './build'
  scripts:   ['./assets/js/app.coffee','./assets/js/**/*.coffee']
  sheets:    ['./assets/css/**/*.styl']
  templates: ['./assets/views/jray.jade']
  vendor:    ['./vendor/**/*.js']


gulp.task 'bundle', ->

  vendor = gulp
    .src  paths.vendor
    .pipe concat 'vendor.min.js'
    # .pipe uglify()

  js = gulp
    .src  paths.scripts
    .pipe coffee() #.on('error',gutil.log)
    .pipe concat 'jray.min.js'
    .pipe ngmin()
    .pipe uglify()

  templates = gulp
    .src  paths.templates
    .pipe jade()
    .pipe templateCache module: 'jray'

  streamqueue objectMode: true, vendor, js, templates
    .pipe concat 'jray.min.js'
    .pipe gulp.dest paths.dest


gulp.task 'css', ->
  gulp
    .src  paths.sheets
    .pipe stylus set: ['compress']
    .pipe gulp.dest paths.dest


gulp.task 'watch', ->
  gulp.watch paths.scripts,   ['bundle']
  gulp.watch paths.templates, ['bundle']
  gulp.watch paths.sheets,    ['css']


gulp.task 'connect', -> connect.server
  root: ['build','examples']
  port: 8765

gulp.task 'dev', ['default','connect','watch']

gulp.task 'default', ['bundle','css']
