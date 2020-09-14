'use strict';

var gulp = require('gulp');
var concat = require('gulp-concat');
var del = require('del');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var rename = require("gulp-rename");
const minify = require("gulp-minify");
// var browserify = require('browserify');

var paths = {
  scripts: 'public/js/*.js',
  reacts: 'public/js/react/*.js',
  // browserified_dir: 'public/js/browserified',
  // browserified_scripts: 'public/js/browserified/*.js',
  images: 'public/img/**/*',
  dist_js: 'public/dist/js',
  scripts_3rdparty: 'public/js_3rdparty/*.js',
  dist: 'public/dist'
  // browserify_this: './public/js/bjjt_utils.js',
  // browserified_this: 'bjjt_utils_bfy.js'
};

const { series } = require('gulp');
const { src, dest }  = require("gulp");

function minifyjs() {
  return src([paths.scripts], { allowEmpty: true })
      .pipe(minify({noSource: true}))
      .pipe(dest(paths.dist_js))
}

// 3rd party scripts are already minified. Just move them
function move_js_3rdparty(){
  return gulp.src(paths.scripts_3rdparty)
    .pipe(gulp.dest(paths.dist_js))
};

// Don't minify react scripts There's a problem in the minify that needs debugging.
function move_js_react(){
  return gulp.src([paths.reacts,paths.scripts])
    .pipe(gulp.dest(paths.dist_js))
};


function scripts(){
  return gulp.src(paths.scripts)
    //    .pipe(uglify().on('error', gutil.log))
    .pipe(gulp.dest(paths.dist_js));
};

// Rerun the task when a file changes
function watch(){
  gulp.watch(paths.scripts, ['scripts']);
  gulp.watch(paths.images, ['images']);
};

function clean() {
  return del([paths.dist]);
};

// function browser_ify() {
//     return browserify({
//       entries: paths.browserify_this,
//       debug: false
//     })
//     .bundle()
//     .pipe(source(paths.browserified_this))
//     .pipe(buffer())
//     .pipe(gulp.dest(paths.dist_js));
// };

exports.default = series( move_js_react, move_js_3rdparty);
exports.clean = series(clean);
