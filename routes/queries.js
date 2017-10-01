// http://mherman.org/blog/2016/03/13/designing-a-restful-api-with-node-and-postgres/#.V6OlC5MrJE4
var server = require( '../server' );
var bluebird = require( 'bluebird' );
var bjjt_utils = require( '../bjjt_utils' );
var options = {
  // Initialization Options
  promiseLib: bluebird
};

// "Guard";1
// "Half Guard";2
// "Side Control";3
// "Mount";4
// "Standing or standing inside guard";5
// "Lying on back";6
// "On all fours or Sprawling";7
// "Kneeling or kneeling inside guard";8
// "Turtle";9
// "North-South";10
// "Seated";11
// "Rear Mount";12
// "Kesa Gatame Side";13
// "Reverse Kesa Side";14
// "Executing Submission";15
// "Lying on Stomach";16
// "N/A";17
var positions = {
  NotAssigned: 17
}

// "Gi only";1
// "No-gi only";2
// "Either Gi or No-gi";3
// "MMA";4
var sports = {
  Either: 3
}
// Recommended by pg-promise guy:
// https://stackoverflow.com/questions/36120435/verify-database-connection-with-pg-promise-when-starting-an-app
const initOptions = {
    promiseLib: bluebird,
    // global event notification;
    error: (error, e) => {
        if (e.cn) {
            // A connection-related error;
            //
            // Connections are reported back with the password hashed,
            // for safe errors logging, without exposing passwords.
            console.log('CN:', e.cn);
            console.log('EVENT:', error.message || error);
        }
    }
};


var pgp = require( 'pg-promise' )( initOptions );

var connectionString;

if ( server.app.get('env') === 'development' ) {
  server.logger.debug( 'dev DB connection : user: ' + process.env.DB_user + ', host: '+ process.env.DB_host+':'+process.env.DB_port + ", ssl: "+process.env.DB_ssl);
  connectionString = {
    user: process.env.DB_user,
    password: process.env.DB_password,
    database: process.env.DB_database,
    port: process.env.DB_port,
    host: process.env.DB_host,
    ssl: false
  };
} else {
  server.logger.info( 'Production connection' );
  connectionString =
    'postgres://uhysicyepxoqup:y4k-5ixpJulBVtwciNexZmuAvJ@ec2-54-163-251-104.compute-1.amazonaws.com:5432/d2fa0lq37cnebt';
}
// var connectionString = 'postgres://localhost:5432/bjjtech';
var db = pgp( connectionString );

// add query functions

module.exports = {
  getAllTech: getAllTech,
  getAllTopicsExtended: getAllTopicsExtended,
  getAllTypes: getAllTypes,
  getAllTopics: getAllTopics,
  getAllSports: getAllSports,
  getAllLevels: getAllLevels,
  getAllPositions: getAllPositions,
  getAllTechInTopic: getAllTechInTopic,

  // Get tech from str
  getTechFromStrInTopic: getTechFromStrInTopic,
  // getTechFromStrInPositionName: getTechFromStrInPositionName,
  // getTechFromStrInTechiqueType: getTechFromStrInTechiqueType,
  getTechFromStr: getTechFromStr,
  //getTechByName: getTechByName,

  getTechBrief: getTechBrief,
  getTech: getTech,
  getTechRelated: getTechRelated,
  createTech: createTech,
  getTechsFromTag: getTechsFromTag

    // updateTech: updateTech,
    // removeTech: removeTech

};

function getAllTech( req, res, next ) {
  // server.logger.debug('getalltech')
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

// This gets the index.html topic list, shich is actually way more than just topics
function getAllTopicsExtended( req, res, next ) {

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
          message: 'Retrieved ALL topicsextended'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getAllTypes( req, res, next ) {

  db.any( "select techniquetype.techniquetype as name, index, 'type' " +
      "as tag from techniquetype" )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ALL techniquetypes'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getAllTopics( req, res, next ) {

  db.any( "select topic.topic as name, index, 'topic' " +
      "as tag from topic" )
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


function getAllSports( req, res, next ) {

  db.any( "select sport.sport as name, index, 'sport' " +
      "as tag from sport" )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ALL sports'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getAllLevels( req, res, next ) {

  db.any( "select skilllevel.levelname as name, index, 'level' " +
      "as tag from skilllevel" )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ALL skillevels'
        } );
    } )
    .catch( function( err ) {
      return next( err );
    } );
}

function getAllPositions( req, res, next ) {
  db.any( "select positionnames.positionname as name, index, 'position' " +
      "as tag from positionnames" )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          message: 'Retrieved ALL positions'
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
      "SELECT technique.name, technique.index, technique.videoid, technique.numimages, topic.topic AS topic_name FROM topic INNER JOIN " +
      "technique ON topic.index = technique.topic WHERE " +
      "name ~* $1 OR setup ~* $1 OR details ~* $1 " +
      "ORDER BY topic_name, technique.name",
      strSearch )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          search: strSearch,
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
    `SELECT * FROM (SELECT technique.*, technique.index AS technique_id, techniquetype.techniquetype AS techniquetype_techniquetype,
    positionnames.positionname AS position_name,
    sport.sport AS sport_sport, topic.topic AS topic_topic , skilllevel.levelname AS level_name FROM
    topic INNER JOIN (
    positionnames INNER JOIN (
    skilllevel INNER JOIN (
    sport INNER JOIN (
    techniquetype INNER JOIN
    technique ON techniquetype.index = technique.type)
    ON sport.index = technique.sport)
    ON skilllevel.index = technique.skilllevel)
    ON positionnames.index = technique.startingpos)
    ON topic.index = technique.topic WHERE technique.index = $1) t
    CROSS JOIN (SELECT COUNT(relatedtechnique.techniquerelated) as numrelated from relatedtechnique where relatedtechnique.technique = $1) c`;

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

function getTechRelated( req, res, next ) {
  var id = req.params.id;

  db.any(
      // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
      `SELECT technique.index AS related, technique.name, relatedtechnique.techniquerelated as technique_id
        FROM relatedtechnique, technique
        WHERE relatedtechnique.technique = $1 and technique.index = relatedtechnique.techniquerelated`,
      id )
    .then( function( data ) {
      res.status( 200 )
        .json( {
          status: 'success',
          data: data,
          id: id,
          message: 'Retrieved techs related to: ' + id
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
  server.logger.debug("Create "+ JSON.stringify(req.body));
  var input_err = false;
  var error_detail = "";
  // Make sure it doesn't already exist
  var name = req.body.name ;
  if ((typeof name !== 'string' ) || (name.length < 1)){
    input_err = true;
    error_detail = "name";
    res.status( 400 )
      .json( {
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      } );
  } else {
    server.logger.debug("dbone=" + name);


  db.oneOrNone(
      // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
      "SELECT index from technique WHERE name ilike $1",
      name )
    .then( function( data ) {
      if (data != null) {
        server.logger.debug("Exists: 1");
        input_err = true;
        error_detail = "Exists: " + JSON.stringify(data.index);
        res.status( 400 )
          .json( {
            status: 'fail',
            data: error_detail,
            message: 'Duplicate'
          } );
      // } else if (( parseInt( data.index ) != NaN ) && (bjjt_utils.isNumeric( data.index))){
      //     server.logger.debug("helper: 2");
      //     input_err = true;
      //     error_detail = data.index;
      //     res.status( 400 )
      //       .json( {
      //         status: 'fail',
      //         data: error_detail,
      //         message: 'Bad input'
      //       } );
      } else {

          // Tech does not exist, create it
          server.logger.debug("Doesn't exist, time to create " + name);

          // "Defenses";1
          // "Escapes";2
          // "Submissions";3
          // "Drills";4
          // "Positions";5
          // "Unbalancing";6
          var type = parseInt( req.body.type );
          server.logger.debug( "type:"+type);
          if ( !bjjt_utils.isNumeric( type) || ( isNaN( type ) ) || (skilllevel < 1)) {
            input_err = true;
            error_detail = "type";
          }

          // "Chokes";1
          // "Arm attacks";2
          // "Shoulder attacks";3
          // "Knee attacks";4
          // "Guard";5
          // "Takedowns and Throws";7
          // "Sweeps";8
          // "Side Controls";9
          // "Mounts";10
          // "Rear Mounts";11
          // "Drill with Partner";12
          // "Drill without Partner";13
          // "Neck or back attacks";14
          // "Ankle attacks";15
          // "Foot attacks";16
          // "Crushes";17
          // "Hip and thigh attacks";18
          // "Conditioning or Flexibility";19
          var topic = parseInt( req.body.topic );
          server.logger.debug( "topic:"+topic);
          if ( !bjjt_utils.isNumeric( topic) || ( isNaN( topic ) ) || (topic < 1) ) {
            input_err = true;
            error_detail = "topic";
          }

          var setup = req.body.setup ;
          server.logger.debug( "setup:"+setup);
          if (typeof setup !== 'string' ){
            setup = "";
          }
          var details = req.body.details;
          server.logger.debug( "details:"+details);
          if ((typeof details !== 'string')|| (details.length < 1)){
            input_err = true;
            error_detail = "details";
          }
          var credit = req.body.credit;
          server.logger.debug( "credit:"+credit);
          if (typeof credit !== 'string' ){
            credit = "";
          }

          // "Gi only";1
          // "No-gi only";2
          // "Either Gi or No-gi";3
          // "MMA";4
          var sport =parseInt( req.body.sport );
          server.logger.debug( "sport:"+sport);
          if ( !bjjt_utils.isNumeric( sport) || ( isNaN( sport ) ) || (sport < 1)) {
            sport = sports.Either;

          }
          // "Guard";1
          // "Half Guard";2
          // "Side Control";3
          // "Mount";4
          // "Standing or standing inside guard";5
          // "Lying on back";6
          // "On all fours or Sprawling";7
          // "Kneeling or kneeling inside guard";8
          // "Turtle";9
          // "North-South";10
          // "Seated";11
          // "Rear Mount";12
          // "Kesa Gatame Side";13
          // "Reverse Kesa Side";14
          // "Executing Submission";15
          // "Lying on Stomach";16
          // "N/A";17
          var startingpos =parseInt( req.body.startingpos );
          if ( !bjjt_utils.isNumeric( startingpos) || ( isNaN( startingpos ) )|| (startingpos < 1) ) {
            startingpos = positions.NotAssigned;
          }
          server.logger.debug( "startingpos:"+startingpos);

          // We don't require this
          var endingpos =parseInt( req.body.endingpos );
          if ( !bjjt_utils.isNumeric( endingpos) || ( isNaN( endingpos ) ) || (endingpos < 1)) {
            endingpos = positions.NotAssigned;
          }
          server.logger.debug( "endingpos:"+endingpos);

          // We don't require this
          var imageurl = "";
          var numimages =parseInt( req.body.numimages );
          if ( !bjjt_utils.isNumeric( numimages) || ( isNaN( numimages ) ) || (numimages < 0)) {
            numimages = 0;
          } else {
            if (numimages > 0){
              // Don't even attempt imageurl if numimages not set
              imageurl = req.body.imageurl
              if ((typeof imageurl !== 'string') || (imageurl.length < 1)){
                input_err = true;
                error_detail = "imageurl";
             }
           }
          }
          // We don't require this
          var videoid = req.body.videoid;

          // We don't require this
          var opponentstartingpos =parseInt( req.body.opponentstartingpos );
          if ( !bjjt_utils.isNumeric( opponentstartingpos) || ( isNaN( opponentstartingpos ) ) || (opponentstartingpos < 0) ) {
            opponentstartingpos = positions.NotAssigned;
          }
          server.logger.debug( "opponentstartingpos:"+opponentstartingpos);

          // 1: beginner, 2: intermed, 3: adv
          var skilllevel = parseInt( req.body.skilllevel );
          if ( !bjjt_utils.isNumeric( skilllevel) || ( isNaN( skilllevel ) ) || (skilllevel < 0) ) {
            skilllevel = 1;
          }

          var rating = 0;
          var ratings = 0;

          if (input_err === true){
            server.logger.debug( "error_detail:"+error_detail);

            res.status( 400 )
              .json( {
                status: 'fail',
                data: error_detail,
                message: 'Bad input'
              } );
          } else {
            // A mixed example for a dynamic column list:
            // const columns = ['type', 'topic', 'name', 'setup', 'details', 'credit', 'sport', 'startingpos', 'endingpos',
            // 'imageurl', 'numimages', 'videoid', 'opponentstartingpos', 'skilllevel', 'lastteachdate', 'rating', 'ratings'];
            // db.query('INSERT INTO ${table~}(${columns^}) VALUES(${type}, ${topic}, ${name}, ${setup}, ${details}, ${credit}, NEXTVAL('technique_id_seq'), ${sport}, ${startingpos}, ${endingpos}, ${imageurl}, ${numimages}, ${videoid}, ${opponentstartingpos}, ${skilllevel}, CURRENT_TIMESTAMP, ${rating}, ${ratings) RETURNING id', {
            //     table: 'technique',
            //     columns: columns.map(pgp.as.name).join(),
            // });
            var strSQL = "insert into technique(type, topic, name, setup, details, credit, sport, startingpos, endingpos, imageurl, numimages, videoid, opponentstartingpos, skilllevel, lastteachdate, rating, ratings) " +
                    "values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, CURRENT_TIMESTAMP, $15, $16) " +
                    "RETURNING index";
            server.logger.debug( "strSQL:"+strSQL);
            db.one(
                strSQL,
                [type, topic, name, setup, details, credit, sport, startingpos, endingpos, imageurl, numimages, videoid, opponentstartingpos, skilllevel, rating, ratings])
              .then( function( data) {
                res.status( 200 )
                  .json( {
                    status: 'success',
                    data: data.index,
                    message: 'Inserted one tech: ' + name
                  } );
              } )
              .catch( function( err ) {
                server.logger.debug( "catch:"+err);
                return next( err );
              } );
            }



        }

    })
    .catch( function( err ) {
      return next( err );
    } );
  }
}

function removeTech( req, res, next ) {
  var techniqueID = parseInt( req.params.id );
  db.result( 'delete from technique where index = $1', techniqueID )
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
