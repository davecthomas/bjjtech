var express = require('express'),
//routes = require('./routes'),
path = require('path'),
favicon = require('serve-favicon'),
// define the home page route
root = require('./routes/root'),
morgan = require('morgan'),
router = express.Router();

// Express is our web server routing engine for node.js
var app = express();
// For dates/times
app.locals.moment = require('moment');
// For logging
app.use(morgan('combined', {
  skip: function (req, res) { return res.statusCode < 400 }
}));

// Our local settings
app.locals.bjjtech_web = {
  port: (process.env.PORT || 8080),
  general: {
    dotcom: 'BJJTech.com',
    title: 'BJJTech',
    description: 'Austin Jiu-Jitsu\'s Brazilian Jiu-Jitsu technique catalog.',
    tagline: 'Untangle the Jits knot',
    year: app.locals.moment().year()
  },
  company: {
    name: 'Austin Jiu-Jitsu.',
    birthyear: 2003
  },
  author: {
    name: 'Dave Thomas',
    contact: 'davidcthomas@gmail.com',
    github: 'davecthomas@github.com'
  }
};

app.set('port', app.locals.bjjtech_web.port);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use('/public', express.static(__dirname + '/public'));
app.use(favicon(__dirname + '/public/img/favicon.ico'));

if ( 'development' == app.get('env')){
  app.locals.pretty = true;
}

// Defile routes
router.get('/', root.getIndex);
router.get('/index', root.getIndex);
router.get('/about', root.getAbout);
router.get('/tech/:id', root.getSingleTech);
router.get('/tech/text/:str', root.getTechFromStr);

// List of routes - all prefixed with /web
app.use('/', router);

module.exports = router;

// Start the app
var server = app.listen(app.get('port'), function() {
  console.log(app.locals.bjjtech_web.general.title + " is running at :" + server.address().address+":" + app.get('port'));
})

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function (err, req, res, next) {
        res.status(err.status || 500);
        res.render('pages/500', {
            message: err.message,
            verbose: true,
            error: err
        });
    });
} else {
  // production error handler
  // no stacktraces leaked to user
  app.use(function (err, req, res, next) {
      res.status(err.status || 500);
      res.render('pages/500', {
          message: err.message,
          verbose: false,
          error: err
      });
  });
}
