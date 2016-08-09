// server.js
var express     = require('express'),
    app         = module.exports = express(),
    path        = require('path'),
    favicon     = require('serve-favicon'),
    morgan      = require('morgan'),
    bodyParser  = require('body-parser');

// For JSON parsing
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// For logging
app.use(morgan('combined', {
  skip: function (req, res) { return res.statusCode < 400 }
}));

// For time
app.locals.moment = require('moment');

// Our app local object
app.locals.bjjtech = {
  general: {
    dotcom: 'BJJTech.com',
    title: 'BJJTech',
    description: 'Austin Jiu-Jitsu\'s Brazilian Jiu-Jitsu technique catalog.',
    tagline: 'Austin Jiu-Jitsu techniques',
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

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use('/public', express.static(__dirname + '/public'));
app.use(favicon(__dirname + '/public/img/favicon.ico'));

if ( 'development' == app.get('env')){
  app.locals.pretty = true;
}

// Defile routes for web app
var router = express.Router();              // get an instance of the express Router

var root = require('./routes/root');        // root.js has our web logic

router.get('/', root.getIndex);
router.get('/index', root.getIndex);
router.get('/about', root.getAbout);
router.get('/tech/:id', root.getSingleTech);
                                                        // http://bjjtech.com/tech/tech-detail.asp?id=387
router.get('/tech/tech-detail.asp', root.getSingleTech); // Attempt compatibility with old url format
router.get('/tech/text/:str', root.getTechFromStr);

// Register DB routes: Our API to the DB
var db = require('./routes/queries');       // queries.js has our DB logic

router.get('/api/tech', db.getAllTech);
router.get('/api/tech/topics', db.getAllTopics);
router.get('/api/tech/topic/:id', db.getAllTechInTopic);
router.get('/api/tech/:id', db.getSingleTech);    // suppoert new style /api/tech/86
router.get('/api/tech', db.getSingleTech);        // support query parameter for old version (/api/tech?id=86)
router.get('/api/tech/brief/:id', db.getTechBrief);
router.get('/api/tech/text/:str', db.getTechFromStr);
router.post('/api/tech', db.createTech);
// router.put('/api/tech/:id', db.updateTech);
// router.delete('/api/tech/:id', db.removeTech);

app.use('/', router);
module.exports = router;

// Kick off the server
app.set('port', (process.env.PORT || 5000));

var server = app.listen(app.get('port'), function() {
  console.log(app.locals.bjjtech.general.title + " is running at :" + server.address().address+":" + app.get('port'));
});
