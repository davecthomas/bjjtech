var web = require( '../server' );

var request = require( 'request' );
var api_url = 'http://localhost:' + process.env.PORT + '/api/';
var queries = require( './queries' );
var bjjt_utils = require( './bjjt_utils' );


// add query functions

module.exports = {
  getIndex: getIndex,
  getAbout: getAbout,
  getAllTech: getAllTech,
  getTechFromStr: getTechFromStr,
  getTech: getTech

};

// define the home page route
function getIndex( req, res ) {
  request( api_url + 'tech/topics', function( error, response, body ) {
    if ( !error && response.statusCode == 200 ) {
      res.render( 'pages/index', {
        response: body
      } );
    }
  } )
};

function getAbout( req, res ) {
  res.render( 'pages/about' );
};

function getAllTech( req, res ) {
  res.render( 'pages/getalltech' );
};

function getTech( req, res ) {
  var techniqueID = 0; // See if this is coming from old ASP-style link ...asp?id=100
  if ( !bjjt_utils.isNumeric( req.query.id ) || ( isNaN( req.query.id ) ) ) {
    if ( bjjt_utils.isNumeric( req.params.id ) ) {
      techniqueID = parseInt( req.params.id ); // Coming from new-style format
    }
  } else {
    techniqueID = parseInt( req.query.id );
  }

  request( api_url + 'tech/' + techniqueID, function( error, response, body ) {
    if ( !error && response.statusCode == 200 ) {
      res.render( 'pages/gettech', {
        response: body
      } );
    }
  } )
};

function getTechFromStr( req, res ) {
  res.render( 'pages/gettechfromstr' );
};


// This is never called but useful in debugging logic in the footer, if needed
/*
exports.footer = function(req, res) {
  res.render('pages/footer');
};*/
