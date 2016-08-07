var web = require('../web_server');

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
  res.render('pages/index');
};

function getAbout(req, res) {
  res.render('pages/about');
};

function getAllTech(req, res) {
  res.render('pages/getalltech');
};

function getSingleTech(req, res) {
  res.render('pages/getsingletech');
};

function getTechFromStr(req, res) {
  res.render('pages/gettechfromstr');
};


// This is never called but useful in debugging logic in the footer, if needed
/*
exports.footer = function(req, res) {
  res.render('pages/footer');
};*/
