var request = require( 'request' );
var api_url = process.env.BJJT_API_ROOT_URL + '/api/';
var queries = require( './queries' );
var bjjt_utils = require( './bjjt_utils' );

// add query functions

module.exports = {
  getIndex: getIndex,
  getHeader: getHeader,
  getAllTech: getAllTech,
  getTechFromStr: getTechFromStr,
  getTech: getTech

};

// define the home page route
function getIndex( req, res ) {
  // req.app.locals.bjjtech.server.logger.info( 'getIndex route calling: ' +  api_url + 'tech/topics' );
  request( api_url + 'tech/topics', function( error, response, body ) {
    if ( !error && response.statusCode == 200 ) {
      res.render( 'pages/index', {
        response: body
      } );
    }
  } )
};

function getHeader( req, res ) {
  res.render( 'pages/gettechfromstr' );
};

function getAllTech( req, res ) {
  res.render( 'pages/getalltech' );
};

function getTech( req, res ) {
  var searchStr = "";
  var techniqueID = 0; // See if this is coming from old ASP-style link ...asp?id=100
  if ( !bjjt_utils.isNumeric( req.query.id ) || ( isNaN( req.query.id ) ) ) {
    if ( bjjt_utils.isNumeric( req.params.id ) ) {
      techniqueID = parseInt( req.params.id ); // Coming from new-style format
    }
  } else {
    techniqueID = parseInt( req.query.id );
  }

  if ( ( req.query.search ) && ( req.query.search.length > 0 ) ) {
    searchStr = req.query.search;
  }

  request( api_url + 'tech/' + techniqueID, function( error, response, body ) {
    if ( !error && response.statusCode == 200 ) {
      res.render( 'pages/gettech', {
        response: body,
        searchparam: searchStr
      } );
    }
  } )
};

function getTechFromStr( req, res ) {
  var search = "";
  if ( req.params.str.length > 0 ) {
    search = req.params.str;
  }
  request( api_url + 'tech/text/' + search, function( error, response, body ) {
    if ( !error && response.statusCode == 200 ) {
      res.render( 'pages/gettechfromstr', {
        response: body
      } );
    }
  } )

};


// This is never called but useful in debugging logic in the footer, if needed
/*
exports.footer = function(req, res) {
  res.render('pages/footer');
};*/
