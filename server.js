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
app.use(express.static(__dirname + '/root'));
app.use(favicon(__dirname + '/public/img/favicon.ico'));

if ('development' == app.get('env')) {
  logger.info('Development environment');
  app.locals.pretty = true;
} else {

}

// Defile routes for web app
var router = express.Router(); // get an instance of the express Router

var root = require('./routes/root'); // root.js has our web logic
// app.all( '/', function( req, res, next ) {
//   res.header( "Access-Control-Allow-Origin", "*" );
//   res.header( "Access-Control-Allow-Headers", "X-Requested-With" );
//   next();
// } );
router.get('/', root.getIndex);
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
// router.post( '/api/tech', db.createTech );
// router.put('/api/tech/:id', db.updateTech);
// router.delete('/api/tech/:id', db.removeTech);

// Next line provides support for root url. Without this, you get a "Cannot get /" error at site root.
app.use('/', router);

// Our app local object
app.locals.bjjtech = {
  general: {
    dotcom: 'BJJTech.com',
    url: 'http://BJJTech.com',
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
    router: router
  }
};

// Kick off the server
app.set('port', (process.env.PORT || 5006));

var server = app.listen(app.get('port'), function() {
  console.log(app.locals.bjjtech.general.title + " is running at :" +
    server.address().address + ":" + app.get('port'));
});

logger.info('Server started');
