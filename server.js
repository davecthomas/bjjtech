// server.js
var express = require( 'express' ),
  app = module.exports = express(),
  path = require( 'path' ),
  favicon = require( 'serve-favicon' ),
  morgan = require( 'morgan' ),
  bodyParser = require( 'body-parser' ),
  winston = require( 'winston' ),
  expressWinston = require( 'express-winston' );

//
// Requiring `winston-papertrail` will expose
// `winston.transports.Papertrail`
//
require( 'winston-papertrail' ).Papertrail;

var winstonPapertrail = new winston.transports.Papertrail( {
  host: 'logs3.papertrailapp.com',
  port: 30625
} )

winstonPapertrail.on( 'error', function( err ) {
  // Handle, report, or silently ignore connection errors and failures
} );

var logger = new winston.Logger( {
  transports: [
    winstonPapertrail,
    new( winston.transports.Console )()
  ]
} );

logger.info( 'BJJ Tech Started' );



app.use( expressWinston.logger( {
  transports: [
    new winston.transports.Console( {
      json: true,
      colorize: true
    } ),
    winstonPapertrail
  ],
  meta: true, // optional: control whether you want to log the meta data about the request (default to true)
  msg: "HTTP {{req.method}} {{req.url}}", // optional: customize the default logging message. E.g. "{{res.statusCode}} {{req.method}} {{res.responseTime}}ms {{req.url}}"
  expressFormat: true, // Use the default Express/morgan request formatting. Enabling this will override any msg if true. Will only output colors with colorize set to true
  colorize: true, // Color the text and status code, using the Express/morgan color palette (text: gray, status: default green, 3XX cyan, 4XX yellow, 5XX red).
  ignoreRoute: function( req, res ) {
      return false;
    } // optional: allows to skip some log messages based on request and/or response
} ) );


// For JSON parsing
app.use( bodyParser.urlencoded( {
  extended: true
} ) );
app.use( bodyParser.json() );

// For logging
app.use( morgan( 'combined', {
  skip: function( req, res ) {
    return res.statusCode < 400
  }
} ) );

// For time
app.locals.moment = require( 'moment' );

// Our app local object
app.locals.bjjtech = {
  general: {
    dotcom: 'BJJTech.com',
    url: 'http://BJJTech.com',
    title: 'BJJTech',
    description: 'Austin Jiu-Jitsu\'s Brazilian Jiu-Jitsu technique catalog.',
    tagline: 'Austin Jiu-Jitsu techniques',
    year: app.locals.moment().year()
  },
  company: {
    name: 'Austin Jiu-Jitsu',
    url: 'http://austinjiujitsu.com',
    birthyear: 2003
  },
  author: {
    name: 'Dave Thomas',
    contact: 'davidcthomas@gmail.com',
    github: 'davecthomas@github.com'
  }
};

app.set( 'views', path.join( __dirname, 'views' ) );
app.set( 'view engine', 'ejs' );
app.use( '/public', express.static( __dirname + '/public' ) );
app.use( favicon( __dirname + '/public/img/favicon.ico' ) );

if ( 'development' == app.get( 'env' ) ) {
  app.locals.pretty = true;
}

// Defile routes for web app
var router = express.Router(); // get an instance of the express Router

var root = require( './routes/root' ); // root.js has our web logic

router.get( '/', root.getIndex );
router.get( '/index', root.getIndex );
router.get( '/about', root.getAbout );
router.get( '/tech/:id', root.getTech ); // support /tech/86
router.get( '/tech', root.getTech ); // support query parameter for old version (/tech?id=86)
// http://bjjtech.com/tech/tech-detail.asp?id=387
router.get( '/tech/tech-detail.asp', root.getTech ); // Attempt compatibility with old url format
router.get( '/tech/text/:str', root.getTechFromStr );

// Register DB routes: Our API to the DB
var db = require( './routes/queries' ); // queries.js has our DB logic

router.get( '/api/tech/all', db.getAllTech );
router.get( '/api/tech/topics', db.getAllTopics );
router.get( '/api/tech/topic/:id', db.getAllTechInTopic );
router.get( '/api/tech/:id', db.getTech ); // suppoert new style /api/tech/86
router.get( '/api/tech', db.getTech ); // support query parameter for old version (/api/tech?id=86)
router.get( '/api/tech/brief/:id', db.getTechBrief );
router.get( '/api/tech/text/:str', db.getTechFromStr );
router.post( '/api/tech', db.createTech );
// router.put('/api/tech/:id', db.updateTech);
// router.delete('/api/tech/:id', db.removeTech);

app.use( '/', router );
module.exports = router;

// Kick off the server
app.set( 'port', ( process.env.PORT || 5000 ) );

var server = app.listen( app.get( 'port' ), function() {
  console.log( app.locals.bjjtech.general.title + " is running at :" +
    server.address().address + ":" + app.get( 'port' ) );
} );
