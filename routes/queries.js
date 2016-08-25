// http://mherman.org/blog/2016/03/13/designing-a-restful-api-with-node-and-postgres/#.V6OlC5MrJE4
var app = require( '../server' );
var promise = require( 'bluebird' );
var bjjt_utils = require( './bjjt_utils' );
var options = {
  // Initialization Options
  promiseLib: promise
};

var pgp = require( 'pg-promise' )( options );

var connectionString;

if ( process.env.NODE_ENV === 'development' ) {
  connectionString = {
    user: process.env.DB_user,
    password: process.env.DB_password,
    database: process.env.DB_database,
    port: process.env.DB_port,
    host: process.env.DB_host,
    ssl: process.env.DB_ssl
  };
} else {
  connectionString =
    'postgres://uhysicyepxoqup:y4k-5ixpJulBVtwciNexZmuAvJ@ec2-54-163-251-104.compute-1.amazonaws.com:5432/d2fa0lq37cnebt';
}
// var connectionString = 'postgres://localhost:5432/bjjtech';
var db = pgp( connectionString );

// add query functions

module.exports = {
  getAllTech: getAllTech,
  getAllTopics: getAllTopics,
  getAllTechInTopic: getAllTechInTopic,

  // Get tech from str
  getTechFromStrInTopic: getTechFromStrInTopic,
  // getTechFromStrInPositionName: getTechFromStrInPositionName,
  // getTechFromStrInTechiqueType: getTechFromStrInTechiqueType,
  getTechFromStr: getTechFromStr,

  getTechBrief: getTechBrief,
  getTech: getTech,
  getTechsFromTag: getTechsFromTag
    // createTech: createTech,
    // updateTech: updateTech,
    // removeTech: removeTech

};

function getAllTech( req, res, next ) {
  db.any( 'select * from technique' )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ALL tech'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getAllTopics( req, res, next ) {
  // req.app.locals.bjjtech.server.logger.info( 'getAllTopics using db: ' + connectionString );

  db.any( "( select positionnames.positionname as name, index, 'position' " +
      "as tag from positionnames where positionname != 'N/A' ) union all( select topic.topic as name, " +
      "index, 'topic' " +
      "as tag from topic ) union all( select techniquetype.techniquetype as name, index, " +
      "'type' " +
      "as tag from techniquetype ) order by 1; " )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ALL topics'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getAllTechInTopic( req, res, next ) {
  var topicID = parseInt( req.params.id );
  db.any(
      'SELECT technique.name, technique.index, technique.videoid, topic.topic AS topic_name FROM topic INNER JOIN ' +
      'technique ON topic.index = technique.topic WHERE topic.index = $1 ORDER BY technique.name',
      topicID )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ALL techs in topic'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getTechFromStr( req, res, next ) {
  var strSearch = req.params.str;

  db.any(
      // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
      "SELECT technique.name, technique.index, technique.videoid, topic.topic AS topic_name FROM topic INNER JOIN " +
      "technique ON topic.index = technique.topic WHERE " +
      "name ~* $1 OR setup ~* $1 OR details ~* $1 " +
      "ORDER BY topic_name, technique.name",
      strSearch )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved techs with search str: ' + strSearch
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}


function getTechFromStrInTopic( req, res, next ) {
  var strSearch = parseInt( req.params.str );
  db.any(
      "select * from technique where name ~* $1 OR setup ~* $1 || OR details ~* $1 ",
      strSearch )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved tech with str ' + strSearch
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getTechBrief( req, res, next ) {
  var techniqueID = parseInt( req.params.id );
  db.one( 'select index, name, setup, details, videoid from technique where index = $1',
      techniqueID )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved tech brief'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}


function getTech( req, res, next ) {
  var techniqueID = 0; // See if this is coming from old ASP-style link ...asp?id=100
  if ( !bjjt_utils.isNumeric( req.query.id ) || ( isNaN( req.query.id ) ) ) {
    if ( bjjt_utils.isNumeric( req.params.id ) ) {
      techniqueID = parseInt( req.params.id ); // Coming from new-style format
    }
  } else {
    techniqueID = parseInt( req.query.id );
  }
  var strSQL =
    "SELECT technique.*, technique.index AS technique_id, techniquetype.techniquetype AS techniquetype_techniquetype, " +
    "positionnames.positionname AS position_name, " +
    "sport.sport AS sport_sport, topic.topic AS topic_topic , skilllevel.levelname AS level_name FROM " +
    "topic INNER JOIN (" +
    "positionnames INNER JOIN (" +
    "skilllevel INNER JOIN (" +
    "sport INNER JOIN (" +
    "techniquetype INNER JOIN technique ON techniquetype.index = technique.type) " +
    "ON sport.index = technique.sport) " +
    "ON skilllevel.index = technique.skilllevel)" +
    "ON positionnames.index = technique.startingpos) " +
    "ON topic.index = technique.topic WHERE technique.index = $1";

  // strSQL = "select * from technique where index = $1";
  db.one( strSQL, techniqueID )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ONE tech'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getTechsFromTag( req, res, next ) {
  var tag = req.params.tag;
  var id = req.params.id;
  var strSQL = "";
  var goodRequest = false;

  switch ( tag ) {
    case "topic":
      strSQL =
        'SELECT technique.name, technique.index, technique.videoid, topic.topic AS tag_name FROM topic INNER JOIN ' +
        'technique ON topic.index = technique.topic WHERE topic.index = $1 ORDER BY technique.name';
      goodRequest = true;
      break;

    case "position":
      strSQL =
        'SELECT technique.name, technique.index, technique.videoid, positionnames.positionname AS tag_name FROM positionnames INNER JOIN ' +
        'technique ON positionnames.index = technique.startingpos WHERE positionnames.index = $1 ORDER BY technique.name';
      goodRequest = true;
      break;

    case "type":
      strSQL =
        'SELECT technique.name, technique.index, technique.videoid, techniquetype.techniquetype AS tag_name FROM techniquetype INNER JOIN ' +
        'technique ON techniquetype.index = technique.type WHERE techniquetype.index = $1 ORDER BY technique.name';
      goodRequest = true;
      break;

    default:
      res.status( 400 )
        .json( {
          status: 'error',
          message: 'Nope. No. Nah gah do it.'
        } );
      return;
  }
  if ( goodRequest && ( parseInt( id ) != NaN ) ) {
    db.any(
        strSQL,
        id )
      .then( function( data ) {
        res.status( 200 )
          .json( {
            status: 'success',
            data: data,
            message: 'Retrieved techs with tag: ' + tag
          } );
      } )
      .catch( function( err ) {
        return next( err );
      } );
  }
}



function updateTech( req, res, next ) {
  db.none(
      'update technique set type=$1, topic=$2, name=$3, setup=$4, details=$5, credit=$6, sport=$7 , startingpos=$8 , endingpos=$9 , opponentstartingpos=$10, skilllevel=$11, lastteachdate=$12 where index=$5', [
        req.body.name, req.body.breed, parseInt( req.body.age ),
        req.body.sex, parseInt( req.params.index )
      ] )
    .then( function() {
      res.status( 200 )
        .json( {
          status: 'success',
          message: 'Updated technique'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function createTech( req, res, next ) {
  req.body.age = parseInt( req.body.age );
  db.none(
      'insert into technique(type, topic, name, setup, details, credit, index, sport, startingpos, endingpos, imageurl, numimages, videoid, opponentstartingpos, skilllevel, lastteachdate, rating, ratings)' +
      'values(${type}, ${topic}, ${name}, ${setup}, ${details}, ${credit}, ${index}, ${sport}, ${startingpos}, ${endingpos}, ${imageurl}, ${numimages}, ${videoid}, ${opponentstartingpos}, ${skilllevel}, ${lastteachdate})',
      req.body )
    .then( function() {
      res.status( 200 )
        .json( {
          status: 'success',
          message: 'Inserted one tech'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function removeTech( req, res, next ) {
  var pupID = parseInt( req.params.id );
  db.result( 'delete from technique where index = $1', pupID )
    .then( function( result ) {
      /* jshint ignore:start */
      res.status( 200 )
        .json( {
          status: 'success',
          message: 'Removed ${result.rowCount} tech'
        } );
      /* jshint ignore:end */
    } )
    .catch( function( err ) {
      return next( err );
    } );
}
