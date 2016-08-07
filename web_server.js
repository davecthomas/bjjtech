var express = require('express'),
//routes = require('./routes'),
path = require('path'),
favicon = require('serve-favicon'),

index = require('./routes/index')

routerRoot = express.Router();

// Express is our web server routing engine for node.js
var app = express();
app.locals.moment = require('moment');

app.locals.bjjtech_web = {
  port: (process.env.PORT || 8080),
  general: {
    dotcom: 'BJJTech.com',
    title: 'BJJTech Web server',
    description: 'Brazilian Jiu-Jitsu technique catalog.',
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

// List of routes
app.use('/', routerRoot);
app.use('/index', index);

// define the home page route
routerRoot.get('/', function(req, res) {
  res.render('pages/index');
});

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
}

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
