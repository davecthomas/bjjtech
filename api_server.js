// server.js

// BASE SETUP
// =============================================================================

// call the packages we need
var express    = require('express');        // call express
var app        = module.exports = express();                 // define our app using express
var bodyParser = require('body-parser');

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.locals.moment = require('moment');

app.locals.bjjtech_api = {
  general: {
    title: 'BJJTech API server',
    description: 'Brazilian Jiu-Jitsu technique catalog.',
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

// ROUTES FOR OUR API
// =============================================================================
var router = express.Router();              // get an instance of the express Router

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get('/', function(req, res) {
    res.json({ message: 'no route at root' });
});


// Register DB routes
var db = require('./routes/queries');

router.get('/tech', db.getAllTech);
router.get('/tech/:id', db.getSingleTech);
router.get('/tech/text/:str', db.getTechFromStr);
router.post('/tech', db.createTech);
router.put('/tech/:id', db.updateTech);
router.delete('/tech/:id', db.removeTech);


// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/api', router);

module.exports = router;



app.set('port', (process.env.PORT || 5000));

var server = app.listen(app.get('port'), function() {
  console.log(app.locals.bjjtech_api.general.title + " is running at :" + server.address().address+":" + app.get('port'));
});