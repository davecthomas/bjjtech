var express = require('express');
var router = express.Router();

// define the home page route
router.get('/', function(req, res) {
  res.render('pages/index');
});

router.get('/about', function(req, res) {
  res.render('pages/about');
});

router.get('/signin', function(req, res) {
  res.render('pages/signin');
});


// This is never called but useful in debugging logic in the footer, if needed
/*
exports.footer = function(req, res) {
  res.render('pages/footer');
};*/

module.exports = router;
