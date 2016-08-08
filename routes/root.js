var web = require('../server');

var request = require('request');
var api_url = 'http://localhost:'+process.env.PORT+'/api/';


// add query functions

module.exports = {
  getIndex: getIndex,
  getAbout: getAbout,
  getAllTech: getAllTech,
  getTechFromStr: getTechFromStr,
  getSingleTech: getSingleTech
};

// define the home page route
function getIndex(req, res) {
  request(api_url+'tech/topics', function (error, response, body) {
    if (!error && response.statusCode == 200) {
      res.render('pages/index', {response: body});
    }
  })
};

function getAbout(req, res) {
  res.render('pages/about');
};

function getAllTech(req, res) {
  res.render('pages/getalltech');
};

function getSingleTech(req, res) {
  var techniqueID = parseInt(req.params.id);
  request(api_url+'tech/'+techniqueID, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      var topics = JSON.parse(body);
      res.render('pages/getsingletech', {response: topics});
    }
  })
};

function getTechFromStr(req, res) {
  res.render('pages/gettechfromstr');
};


// This is never called but useful in debugging logic in the footer, if needed
/*
exports.footer = function(req, res) {
  res.render('pages/footer');
};*/
