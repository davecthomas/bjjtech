var express = require('express');
var router = express.Router();

var db = require('./queries');


router.get('/api/tech', db.getAllTech);
router.get('/api/tech/:id', db.getSingleTech);
router.post('/api/tech', db.createTech);
router.put('/api/tech/:id', db.updateTech);
router.delete('/api/tech/:id', db.removeTech);


module.exports = router;

var app = express();
app.locals.moment = require('moment');

app.locals.bjjtech = {
  site: {
    title: 'BJJTech',
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

app.set('port', (process.env.PORT || 5000));

var server = app.listen(app.get('port'), function() {
  console.log(app.locals.bjjtech.site.title + " is running at :" + server.address().address+":" + app.get('port'));
});

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
