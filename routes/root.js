var request = require( 'request' );

function getAPI( req){
  var api_url = process.env.BJJT_API_ROOT_URL + '/api/';
  if (req.app.get('env') === 'development' ){
    api_url = process.env.BJJT_API_ROOT_URL + ":"+ req.app.get( 'port' )+'/api/';
    // req.app.locals.bjjtech.server.logger.info( 'Dev environment API url set to ' +  api_url );
  }
  return api_url;
}

function getRoot( req){
  var root_url = process.env.BJJT_API_ROOT_URL;
  if (req.app.get('env') === 'development' ){
    root_url = process.env.BJJT_API_ROOT_URL + ":"+ req.app.get( 'port' ) + "/";
    req.app.locals.bjjtech.server.logger.info( 'Dev environment root url set to ' +  root_url );
  }
  return root_url;
}

var queries = require( './queries' );
var bjjt_utils = require( '../bjjt_utils' );

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
  var api_url = getAPI(req);
  var root_url = getRoot(req);
  request( api_url + 'tech/topics', function( error, response, body ) {
    if ( !error && response.statusCode == 200 ) {
      req.app.locals.bjjtech.server.logger.info( 'Response' + response.statusCode);
      res.render( 'pages/index', {
        api_url: api_url,
        root_url: root_url,
        response: body
      } );
    }
  } )
};

function getHeader( req, res ) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);
  res.render( 'pages/gettechfromstr',{
    api_url: api_url,
    root_url: root_url
  });
};

function getAllTech( req, res ) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);
  res.render( 'pages/getalltech',{
    api_url: api_url,
    root_url: root_url,
  });
};

function getTech( req, res ) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);
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
        api_url: api_url,
        root_url: root_url,
        response: body,
        searchparam: searchStr
      } );
    }
  } )
};

function getTechFromStr( req, res ) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);
  var search = "";
  if ( req.params.str.length > 0 ) {
    search = req.params.str;
  }
  request( api_url + 'tech/text/' + search, function( error, response, body ) {
    if ( !error && response.statusCode == 200 ) {
      res.render( 'pages/gettechfromstr', {
        api_url: api_url,
        root_url: root_url,
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
