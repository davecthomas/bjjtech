'use strict';

var gulp = require('gulp');
var gutil = require('gulp-util');
var concat = require('gulp-concat');
// var uglify = require('gulp-uglify');
var gutil = require('gulp-util');
var del = require('del');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var rename = require("gulp-rename");

var paths = {
  scripts: 'public/js/*.js',
  images: 'public/img/**/*',
  dist_js: 'public/dist/js',
  scripts_3rdparty: 'public/js_3rdparty/*.js',
  dist: 'public/dist',
  browserify_this: './bjjt_utils.js',
  browserified_this: 'bjjt_utils.min.js'
};

const babel = require("gulp-babel");

gulp.task('minify', () => {
  return gulp.src(paths.scripts)
    .pipe(babel({
      presets: ['babili']
    }))
    .pipe(rename({
      suffix: '.min'
    }))
    .pipe(gulp.dest(paths.dist_js))
})
// 3rd party scripts are already minified. Just move them
gulp.task('move_js_3rdparty', () => {
  return gulp.src(paths.scripts_3rdparty)
    .pipe(gulp.dest(paths.dist_js))
});


gulp.task('scripts', function() {
  return gulp.src(paths.scripts)
    //    .pipe(uglify().on('error', gutil.log))
    .pipe(gulp.dest(paths.dist_js));
});

// Rerun the task when a file changes
gulp.task('watch', function() {
  gulp.watch(paths.scripts, ['scripts']);
  gulp.watch(paths.images, ['images']);
});

// From http://blog.revathskumar.com/2016/02/browserify-with-gulp.html
gulp.task('browserify', () => {
  browserify({
      entries: paths.browserify_this,
      debug: false
    })
    .bundle()
    .pipe(source(paths.browserified_this))
    .pipe(buffer())
    // .pipe(uglify())
    .pipe(gulp.dest(paths.dist_js));
});

gulp.task('clean', function() {
  return del([paths.dist]);
});

gulp.task('watching', ['watch', 'browserify', 'scripts']);
gulp.task('default', ['minify', 'move_js_3rdparty']);
//gulp.task('default', ['browserify', 'scripts']);
//gulp.task('default', [ 'browserify' ]);


//
// // create a default task and just log a message
// gulp.task('minify', function() {
//   return gutil.log('Gulp is running!')
//
// });
//
// gulp.task('dependenttask', ['minify'], function() {
//   //do stuff after 'mytask' is done.
//   return gutil.log('Next task')
// });
