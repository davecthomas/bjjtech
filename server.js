// server.js
var express = require('express'),
  app = express(),
  path = require('path'),
  favicon = require('serve-favicon'),
  morgan = require('morgan'),
  bodyParser = require('body-parser'),
  winston = require('winston');

require('winston-papertrail').Papertrail;

var winstonPapertrail = new winston.transports.Papertrail({
  host: 'logs3.papertrailapp.com',
  port: 30625
})

winstonPapertrail.on('error', function(err) {
  // Handle, report, or silently ignore connection errors and failures
});

var logger = new winston.Logger({
  transports: [
    winstonPapertrail,
    new(winston.transports.Console)({
      level: app.get('env') === 'development' ? 'debug' : 'info'
    })
  ]
});

logger.info('BJJ Tech Started');

module.exports = {
  app: app,
  logger: logger
}

// For JSON parsing
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));


// For logging
app.use(morgan('combined', {
  skip: function(req, res) {
    return res.statusCode < 400
  }
}));

// For time
app.locals.moment = require('moment');

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use('/public', express.static(__dirname + '/public'));
app.use(express.static(__dirname + '/root')); // Used to identify this to Norton as nice site
app.use(favicon(__dirname + '/public/img/favicon.ico'));

if ('development' == app.get('env')) {
  logger.info('Development environment');
  logger.info('2FA Auth not required ' + process.env.BJJT_NO_2FA);
  app.locals.pretty = true;
} else {

}

app.set('port', (process.env.PORT || 5006));

// AUTH0

// const passport = require('passport');
// const Auth0Strategy = require('passport-auth0');

// var callbackURL = process.env.BJJT_WEB_ROOT_URL + '/callback';
// var id_jwtoken;
// // Override - need port on localhost
// if (app.get('env') === 'development') {
//   callbackURL = process.env.BJJT_WEB_ROOT_URL + ":" + app.get('port') + '/callback';
// }
// Configure Passport to use Auth0{
// const strategy = new Auth0Strategy({
//     domain: 'app54706413.auth0.com',
//     clientID: 'lDBeX4UppsBW025nKYCLdfrfVoofIz9j',
//     clientSecret: 'MIRUQ8c3w4ozNM_p03uCr1DbuxEciiw-je7-VOZrsxRxmsoKIsm7Zt91jSzvdQ3c',
//     callbackURL: callbackURL
//   },
//   function(accessToken, refreshToken, extraParams, profile, done) {
//     // accessToken is the token to call Auth0 API (not needed in the most cases)
//     // extraParams.id_token has the JSON Web Token
//     // profile has all the information from the user
//     id_jwtoken = extraParams.id_token;
//     return done(null, profile);
//   }
// );
//
// passport.use(strategy);
//
// // This can be used to keep a smaller payload
// passport.serializeUser(function(user, done) {
//   done(null, user);
// });
//
// passport.deserializeUser(function(user, done) {
//   done(null, user);
// });
//
// app.use(passport.initialize());
// app.use(passport.session());

// Defile routes for web app
var router = express.Router(); // get an instance of the express Router
// This is part of the auth0 stuff. Helps us quickly determine if user is logged in.
// var ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn();

var root = require('./routes/root'); // root.js has our web logic
var user = require('./routes/user');
router.get('/api/user/is/:nick', user.isUser);


var index = require('./routes/index');

require('./routes/index')(router);
router.get('/', root.getIndex);
router.get('/privacy', root.getPrivacy);
router.get('/index', root.getIndex);
router.get('/hdr', root.getHeader);
router.get('/tech/:id', root.getTech); // support /tech/86
router.get('/tech', root.getTech); // support query parameter for old version (/tech?id=86)
// Important! If you try to make this tech/new, it interprets the "new" as a techniqueID and calls the wrong url
router.get('/technew', root.newTech);
router.get('/tech/update/:id', root.updateTech);
router.get('/tech/:id/edit', root.updateTech);
// http://bjjtech.com/tech/tech-detail.asp?id=387
router.get('/tech/tech-detail.asp', root.getTech); // Attempt compatibility with old url format
router.get('/tech/text/:str', root.getTechFromStr);

// school support
router.get('/school/:id', root.getSchool);

// course support
router.get('/course/:id', root.getCourse);

// class support
router.get('/class/:id', root.getClass);


// Register DB routes: Our API to the DB
var db = require('./routes/queries'); // queries.js has our DB logic

router.get('/api/tech/all', db.getAllTech);
router.get('/api/tech/topicsextended', db.getAllTopicsExtended);
router.get('/api/tech/types', db.getAllTypes);
router.get('/api/tech/topics', db.getAllTopics);
router.get('/api/tech/sports', db.getAllSports);
router.get('/api/tech/levels', db.getAllLevels);
router.get('/api/tech/positions', db.getAllPositions);
router.get('/api/tech/topic/:id', db.getAllTechInTopic);
router.get('/api/tech/:id', db.getTech); // support new style /api/tech/86
router.get('/api/tech', db.getTech); // support query parameter for old version (/api/tech?id=86)
router.get('/api/tech/related/:id', db.getTechRelated);
router.post('/api/tech/new', db.createTech);
router.post('/api/tech/update', db.updateTech);
//router.get( '/api/tech/name/:name', db.getTechByName );
router.get('/api/tech/brief/:id', db.getTechBrief);
router.get('/api/tech/text/:str', db.getTechFromStr);
router.get('/api/tech/tag/:tag/:id', db.getTechsFromTag);
router.delete('/api/tech/:id/:twofactor', db.removeTech);

router.get('/api/school/:id', db.getSchool);
router.get('/api/schools', db.getAllSchools);
router.post('/api/school/new', db.createSchool);
router.post('/api/school/update', db.updateSchool);
router.delete('/api/school/:id/:twofactor', db.removeSchool);

router.get('/api/course/:id', db.getCourse);
router.get('/api/courses/:schoolid', db.getAllCourses);
router.post('/api/course/new', db.createCourse);
router.post('/api/course/update', db.updateCourse);
router.delete('/api/course/:id/:twofactor', db.removeCourse);

router.get('/api/class/:id', db.getClass);
router.get('/api/classes/:courseid', db.getAllClasses);
router.get('/api/classes/school/:schoolid', db.getAllClassesInSchool);
router.post('/api/class/new', db.createClass);
router.post('/api/class/update', db.updateClass);
router.delete('/api/class/:id/:twofactor', db.removeClass);

router.get('/api/classtech/:classid', db.getTechsInClass);
router.get('/api/classestech/:techid/:schoolid', db.getAllClassesWithTech);
router.post('/api/classtech/news', db.addTechsToClass);
router.post('/api/classtech/update', db.updateTechsInClass);
router.delete('/api/classtech/:classid/:twofactor', db.removeTechsFromClass);
router.delete('/api/classtech/:classid/:techid/:twofactor', db.removeTechFromClass);

// Next line provides support for root url. Without this, you get a "Cannot get /" error at site root.
app.use('/', router);

// Our app local object
app.locals.bjjtech = {
  general: {
    dotcom: 'BJJTech.herokuapp.com',
    url: 'http://BJJTech.herokuapp.com',
    title: 'BJJTech',
    pagetitle: 'BJJTech, the Brazilian Jiu-Jitsu Technique Catalog ',
    description: 'Dave Thomas\' Brazilian Jiu-Jitsu technique catalog.',
    tagline: 'Brazilian Jiu-Jitsu techniques',
    year: app.locals.moment().year()
  },
  company: {
    name: 'Seattle Jiu-Jitsu, LLC',
    url: 'http://www.seattlejiujitsu.com',
    birthyear: 2003
  },
  author: {
    name: 'Dave Thomas',
    contact: 'davidcthomas@gmail.com',
    github: 'davecthomas@github.com'
  },
  server: {
    logger: logger,
    router: router,
    env: app.get('env')
  },
  auth: {
    // ensureLoggedIn: ensureLoggedIn, // I havent figured this out
    // jwtoken: id_jwtoken // I haven't figured this out
  }
};

var server = app.listen(app.get('port'), function() {
  console.log(app.locals.bjjtech.general.title + " is running at :" +
    server.address().address + ":" + app.get('port'));
});

logger.info('Server started');
