// http://mherman.org/blog/2016/03/13/designing-a-restful-api-with-node-and-postgres/#.V6OlC5MrJE4
var server = require('../server');
// var bluebird = require('bluebird');
var bjjt_utils = require('../public/dist/js/bjjt_utils.min.js');
var speakeasy = require("speakeasy");
var qrcode = require("qrcode");
// var options = {
//   // Initialization Options
//   promiseLib: bluebird
// };

var twoFactor = {
  secret: 'IYVDQXKGM5RFWXLTPFBXQMD2JF5XUJKWK42GMKC3KBNES2KQFQ7Q',
  issuer: 'bjjtech.com'
};

var types = {
  Undefined: 0,
  Defenses: 1,
  Escapes: 2,
  Submissions: 3,
  Drills: 4,
  Positions: 5,
  Unbalancing: 6
};


var positions = {
  Undefined: 0,
  Guard: 1,
  HalfGuard: 2,
  SideControl: 3,
  Mount: 4,
  Standingorstandinginsideguard: 5,
  Lyingonback: 6,
  OnallfoursorSprawling: 7,
  Kneeling: 8,
  Turtle: 9,
  NorthSouth: 10,
  Seated: 11,
  RearMount: 12,
  KesaGatameSide: 13,
  ReverseKesaSide: 14,
  ExecutingSubmission: 15,
  LyingonStomach: 16,
  NotAssigned: 17
};

var topics = {
  Undefined: 0,
  Chokes: 1,
  Armattacks: 2,
  Shoulderattacks: 3,
  Kneeattacks: 4,
  Guard: 5,
  TakedownsandThrows: 7,
  Sweeps: 8,
  SideControls: 9,
  Mounts: 10,
  RearMounts: 11,
  DrillwithPartner: 12,
  DrillwithoutPartner: 13,
  Neckorbackattacks: 14,
  Ankleattacks: 15,
  Footattacks: 16,
  Crushes: 17,
  Hipandthighattacks: 18,
  ConditioningFlexibility: 19
};

// "Gi only";1
// "No-gi only";2
// "Either Gi or No-gi";3
// "MMA";4
var sports = {
  Undefined: 0,
  Either: 3
};

var levels = {
  Undefined: 0
};

// // Recommended by pg-promise guy:
// // https://stackoverflow.com/questions/36120435/verify-database-connection-with-pg-promise-when-starting-an-app
// const initOptions = {
//   promiseLib: bluebird,
//   // global event notification;
//   error: (error, e) => {
//     if (e.cn) {
//       // A connection-related error;
//       //
//       // Connections are reported back with the password hashed,
//       // for safe errors logging, without exposing passwords.
//       console.log('CN:', e.cn);
//       console.log('EVENT:', error.message || error);
//     }
//   }
// };
//
//
// var pgp = require('pg-promise')(initOptions);

var db = bjjt_utils.getConnection(server);

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
  updateTech: updateTech,
  getTechsFromTag: getTechsFromTag,
  removeTech: removeTech,

  getSchool: getSchool,
  getAllSchools: getAllSchools,
  createSchool: cuSchool,
  updateSchool: cuSchool,
  removeSchool: removeSchool,

  getCourse: getCourse,
  getAllCourses: getAllCourses,
  createCourse: cuCourse,
  updateCourse: cuCourse,
  removeCourse: removeCourse,

  getClass: getClass,
  getAllClasses: getAllClasses,
  getAllClassesInSchool: getAllClassesInSchool,
  createClass: cuClass,
  updateClass: cuClass,
  removeClass: removeClass,

  getTechsInClass: getTechsInClass,
  getAllClassesWithTech: getAllClassesWithTech,
  addTechsToClass: addTechsToClass,
  updateTechsInClass: updateTechsInClass,
  removeTechsFromClass: removeTechsFromClass,
  removeTechFromClass: removeTechFromClass
};

function check2FA(req, callback) {
  var input_err = false;
  var error_detail = "";
  // Double negative, so our default is to fail safe, meaning require 2FA if we can't find the setting
  if (process.env.BJJT_NO_2FA == 'false') {
    // Validate inputs: Check req.params and req.body
    var twofactor = req.params.twofactor;
    if ((typeof twofactor !== 'string') || (twofactor.length < 1)) {
      twofactor = req.body.twofactor;
      if ((typeof twofactor !== 'string') || (twofactor.length < 1)) {
        input_err = true;
        error_detail = "twofactor";
      }
    }
    if (speakeasy.totp.verify({
        secret: twoFactor.secret,
        encoding: 'base32',
        token: twofactor,
        window: 2
      })) {
      callback({
        status: true
      });
    } else {
      server.logger.debug('2fa bad');
      callback({
        status: false,
        detail: error_detail
      });
    }
  } else {
    server.logger.debug('2fa bypass');
    callback({
      status: true
    });
  }
}

// This should be used to generate new secrets for registering users, eventually.
// It would take a user email address.
function generate2FASecret(user_email) {
  // Generate a secret, if needed
  var secret = speakeasy.generateSecret();

  // Use otpauthURL() to get a custom authentication URL for SHA512
  var url = speakeasy.otpauthURL({
    secret: secret.ascii,
    label: user_email,
    issuer: twoFactor.issuer
  });
  qrcode.toDataURL(url, function(err, data_url) {
    console.log(data_url); // get QR code data URL
  });
  // TO DO: put this in a login page once they give you a user email address
  // qrcode.toFile("qr5.png",url, function (err) {
  //     if (err) throw err;
  //     console.log('done');
  // });
  var ret = {
    secret: secret.ascii,
    url: url
  };
  return ret;
}

function getAllTech(req, res, next) {
  // server.logger.debug('getalltech')
  db.any('select * from technique order by name')
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL tech'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

// This gets the index.html topic list, shich is actually way more than just topics
function getAllTopicsExtended(req, res, next) {

  db.any("( select positionnames.positionname as name, index, 'position' " +
      "as tag from positionnames where positionname != 'N/A' ) union all( select topic.topic as name, " +
      "index, 'topic' " +
      "as tag from topic ) union all( select techniquetype.techniquetype as name, index, " +
      "'type' " +
      "as tag from techniquetype ) order by 1; ")
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL topicsextended'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getAllTypes(req, res, next) {

  db.any("select techniquetype.techniquetype as name, index, 'type' " +
      "as tag from techniquetype order by name")
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL techniquetypes'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getAllTopics(req, res, next) {

  db.any("select topic.topic as name, index, 'topic' " +
      "as tag from topic order by name")
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL topics'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}


function getAllSports(req, res, next) {

  db.any("select sport.sport as name, index, 'sport' " +
      "as tag from sport")
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL sports'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getAllLevels(req, res, next) {

  db.any("select skilllevel.levelname as name, index, 'level' " +
      "as tag from skilllevel")
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL skillevels'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getAllPositions(req, res, next) {
  db.any("select positionnames.positionname as name, index, 'position' " +
      "as tag from positionnames order by name")
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL positions'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getAllTechInTopic(req, res, next) {
  var topicID = parseInt(req.params.id);
  db.any(
      'SELECT technique.name, technique.index, technique.videoid, topic.topic AS topic_name FROM topic INNER JOIN ' +
      'technique ON topic.index = technique.topic WHERE topic.index = $1 ORDER BY technique.name',
      topicID)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL techs in topic'
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getTechFromStr(req, res, next) {
  var strSearch = req.params.str;

  db.any(
      // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
      `SELECT technique.name, technique.index, technique.videoid, technique.numimages, topic.topic AS topic_name
      FROM topic
      INNER JOIN technique ON topic.index = technique.topic
      WHERE name~ * $1 OR setup~ * $1 OR details~ * $1 ORDER BY topic_name, technique.name`,
      strSearch)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          search: strSearch,
          message: 'Retrieved techs with search str: ' + strSearch
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getTechFromStrInTopic(req, res, next) {
  var strSearch = parseInt(req.params.str);
  db.any(
      "select * from technique where name ~* $1 OR setup ~* $1 || OR details ~* $1 ",
      strSearch)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved tech with str ' + strSearch
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getTechBrief(req, res, next) {
  var techniqueID = parseInt(req.params.id);
  db.one('select index, name, setup, details, videoid from technique where index = $1',
      techniqueID)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved tech brief'
        });
    })
    .catch(function(err) {
      res.status(404)
        .json({
          status: 'object not found',
          code: err.code,
          id: id,
          message: err.message
        });
    });
}


function getTech(req, res, next) {
  var techniqueID = 0; // See if this is coming from old ASP-style link ...asp?id=100
  if (!bjjt_utils.isNumeric(req.query.id) || (isNaN(req.query.id))) {
    if (bjjt_utils.isNumeric(req.params.id)) {
      techniqueID = parseInt(req.params.id); // Coming from new-style format
    }
  } else {
    techniqueID = parseInt(req.query.id);
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
    CROSS JOIN (SELECT COUNT(relatedtechnique.techniquerelated) as numrelated from relatedtechnique where relatedtechnique.technique = $1) r
    CROSS JOIN (SELECT COUNT(classtech.techid) as numclasses from classtech where classtech.techid = $1) c`;

  // strSQL = "select * from technique where index = $1";
  db.one(strSQL, techniqueID)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ONE tech'
        });
    })
    .catch(function(err) {
      res.status(404)
        .json({
          status: 'object not found',
          code: err.code,
          id: id,
          message: err.message
        });
    });
}

function getTechRelated(req, res, next) {
  var id = req.params.id;

  db.any(
      // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
      `SELECT technique.index AS related, technique.name as techname, relatedtechnique.techniquerelated as techid
        FROM relatedtechnique, technique
        WHERE relatedtechnique.technique = $1 and technique.index = relatedtechnique.techniquerelated`,
      id)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          id: id,
          message: 'Retrieved techs related to: ' + id
        });
    })
    .catch(function(err) {
      return next(err);
    });
}

function getTechsFromTag(req, res, next) {
  var tag = req.params.tag;
  var id = req.params.id;
  var strSQL = "";
  var goodRequest = false;

  switch (tag) {
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
      res.status(400)
        .json({
          status: 'error',
          message: 'Nope. No. Nah gah do it.'
        });
      return;
  }
  if (goodRequest && (parseInt(id) != NaN)) {
    db.any(
        strSQL,
        id)
      .then(function(data) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            message: 'Retrieved techs with tag: ' + tag
          });
      })
      .catch(function(err) {
        return next(err);
      });
  }
}



function updateTech(req, res, next) {
  server.logger.debug("updateTech " + JSON.stringify(req.body));
  var input_err = false;
  var error_detail = "";

  // Index is required
  var index = parseInt(req.body.index);
  if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
    input_err = true;
    error_detail = "index";
  }

  // Name is required
  var name = req.body.name;
  if ((typeof name !== 'string') || (name.length < 1)) {
    input_err = true;
    error_detail = "name";
  }

  // Type is required
  var type = parseInt(req.body.type);
  if (!bjjt_utils.isNumeric(type) || (isNaN(type)) || (type < 1)) {
    input_err = true;
    error_detail = "type";
  }

  // Required
  var topic = parseInt(req.body.topic);
  if (!bjjt_utils.isNumeric(topic) || (isNaN(topic)) || (topic < 1)) {
    input_err = true;
    error_detail = "topic";
  }

  // Not required
  var setup = req.body.setup;
  if (typeof setup !== 'string') {
    setup = "";
  }
  // Required
  var details = req.body.details;
  if ((typeof details !== 'string') || (details.length < 1)) {
    input_err = true;
    error_detail = "details";
  }

  // Not required
  var credit = req.body.credit;
  if (typeof credit !== 'string') {
    credit = "";
  }

  // Default if not set
  var sport = parseInt(req.body.sport);
  if (!bjjt_utils.isNumeric(sport) || (isNaN(sport)) || (sport < 1)) {
    sport = sports.Either;

  }

  var startingpos = parseInt(req.body.startingpos);
  if (!bjjt_utils.isNumeric(startingpos) || (isNaN(startingpos)) || (startingpos < 1)) {
    startingpos = positions.NotAssigned;
  }

  // We don't require this
  var endingpos = parseInt(req.body.endingpos);
  if (!bjjt_utils.isNumeric(endingpos) || (isNaN(endingpos)) || (endingpos < 1)) {
    endingpos = positions.NotAssigned;
  }

  // We don't require this
  var imageurl = "";
  var numimages = parseInt(req.body.numimages);
  if (!bjjt_utils.isNumeric(numimages) || (isNaN(numimages)) || (numimages < 0)) {
    numimages = 0;
  } else {
    if (numimages > 0) {
      // Don't even attempt imageurl if numimages not set
      imageurl = req.body.imageurl
      if ((typeof imageurl !== 'string') || (imageurl.length < 1)) {
        input_err = true;
        error_detail = "imageurl";
      }
    }
  }
  // We don't require this
  var videoid = req.body.videoid;
  if (typeof videoid !== 'string') {
    videoid = "";
  }
  // We don't require this
  var opponentstartingpos = parseInt(req.body.opponentstartingpos);
  if (!bjjt_utils.isNumeric(opponentstartingpos) || (isNaN(opponentstartingpos)) || (opponentstartingpos < 0)) {
    opponentstartingpos = positions.NotAssigned;
  }

  // 1: beginner, 2: intermed, 3: adv
  var skilllevel = parseInt(req.body.skilllevel);
  if (!bjjt_utils.isNumeric(skilllevel) || (isNaN(skilllevel)) || (skilllevel < 0)) {
    skilllevel = 1;
  }

  // Not implemented
  var rating = 0;
  var ratings = 0;

  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    check2FA(req, function(authresult) {
      if (authresult.status) {
        var strSQL = `update technique
                      set type=$1, topic=$2, name=$3, setup=$4, details=$5, credit=$6, sport=$7 ,
                      startingpos=$8 , endingpos=$9 , opponentstartingpos=$10, skilllevel=$11, imageurl=$12, numimages=$13 , videoid=$14  where index=$15`;
        db.none(
            strSQL, [type, topic, name, setup, details, credit, sport, startingpos, endingpos, opponentstartingpos, skilllevel, imageurl, numimages, videoid, index])
          .then(function(data) {
            res.status(200)
              .json({
                status: 'success',
                message: 'Updated tech: ' + name,
                index: index
              });
          })
          .catch(function(err) {
            server.logger.debug("catch:" + err);
            return next(err);
          });
      } else {
        //        var tfa = generate2FASecret( "davidcthomas@gmail.com");
        res.status(400)
          .json({
            status: 'fail',
            //            data: tfa,
            message: 'auth'
          });
      }
    });
  }
}

function createTech(req, res, next) {
  server.logger.debug("Create " + JSON.stringify(req.body));
  var input_err = false;
  var error_detail = "";
  // Make sure it doesn't already exist
  var name = req.body.name;
  if ((typeof name !== 'string') || (name.length < 1)) {
    input_err = true;
    error_detail = "name";
    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    db.oneOrNone(
        // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
        "SELECT index from technique WHERE name ilike $1",
        name)
      .then(function(data) {
        if (data != null) {
          server.logger.debug("Exists: 1");
          input_err = true;
          error_detail = "Exists: " + JSON.stringify(data.index);
          res.status(400)
            .json({
              status: 'fail',
              data: error_detail,
              message: 'Duplicate'
            });

        } else {

          // Tech does not exist, create it
          server.logger.debug("Doesn't exist, time to create " + name);

          var type = parseInt(req.body.type);
          if (!bjjt_utils.isNumeric(type) || (isNaN(type)) || (type < 1)) {
            input_err = true;
            error_detail = "type";
          }

          var topic = parseInt(req.body.topic);
          if (!bjjt_utils.isNumeric(topic) || (isNaN(topic)) || (topic < 1)) {
            input_err = true;
            error_detail = "topic";
          }

          var setup = req.body.setup;
          if (typeof setup !== 'string') {
            setup = "";
          }
          var details = req.body.details;
          if ((typeof details !== 'string') || (details.length < 1)) {
            input_err = true;
            error_detail = "details";
          }
          var credit = req.body.credit;
          if (typeof credit !== 'string') {
            credit = "";
          }

          var sport = parseInt(req.body.sport);
          if (!bjjt_utils.isNumeric(sport) || (isNaN(sport)) || (sport < 1)) {
            sport = sports.Either;

          }

          // Default if not set
          var startingpos = parseInt(req.body.startingpos);
          if (!bjjt_utils.isNumeric(startingpos) || (isNaN(startingpos)) || (startingpos < 1)) {
            startingpos = positions.NotAssigned;
          }

          // Default if not set
          var endingpos = parseInt(req.body.endingpos);
          if (!bjjt_utils.isNumeric(endingpos) || (isNaN(endingpos)) || (endingpos < 1)) {
            endingpos = positions.NotAssigned;
          }

          // We don't require this
          var imageurl = "";
          var numimages = parseInt(req.body.numimages);
          if (!bjjt_utils.isNumeric(numimages) || (isNaN(numimages)) || (numimages < 0)) {
            numimages = 0;
          } else {
            if (numimages > 0) {
              // Don't even attempt imageurl if numimages not set
              imageurl = req.body.imageurl
              if ((typeof imageurl !== 'string') || (imageurl.length < 1)) {
                input_err = true;
                error_detail = "imageurl";
              }
            }
          }
          // We don't require this
          var videoid = req.body.videoid;
          if (typeof videoid !== 'string') {
            videoid = "";
          }
          // We don't require this
          var opponentstartingpos = parseInt(req.body.opponentstartingpos);
          if (!bjjt_utils.isNumeric(opponentstartingpos) || (isNaN(opponentstartingpos)) || (opponentstartingpos < 0)) {
            opponentstartingpos = positions.NotAssigned;
          }

          // 1: beginner, 2: intermed, 3: adv
          var skilllevel = parseInt(req.body.skilllevel);
          if (!bjjt_utils.isNumeric(skilllevel) || (isNaN(skilllevel)) || (skilllevel < 0)) {
            skilllevel = 1;
          }

          var rating = 0;
          var ratings = 0;

          if (input_err === true) {
            server.logger.debug("error_detail:" + error_detail);

            res.status(400)
              .json({
                status: 'fail',
                data: error_detail,
                message: 'Bad input'
              });
          } else {
            check2FA(req, function(authresult) {
              if (authresult.status) {
                var strSQL = "insert into technique(type, topic, name, setup, details, credit, sport, startingpos, endingpos, imageurl, numimages, videoid, opponentstartingpos, skilllevel, lastteachdate, rating, ratings) " +
                  "values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, CURRENT_TIMESTAMP, $15, $16) " +
                  "RETURNING index";
                db.one(
                    strSQL, [type, topic, name, setup, details, credit, sport, startingpos, endingpos, imageurl, numimages, videoid, opponentstartingpos, skilllevel, rating, ratings])
                  .then(function(data) {
                    res.status(200)
                      .json({
                        status: 'success',
                        data: data.index,
                        message: 'Inserted one tech: ' + name
                      });
                  })
                  .catch(function(err) {
                    server.logger.debug("catch:" + err);
                    return next(err);
                  });

              } else {
                res.status(400)
                  .json({
                    status: 'fail',
                    message: 'auth'
                  });
              }
            });
          }
        }
      })
      .catch(function(err) {
        return next(err);
      });
  }
}

function removeTech(req, res, next) {
  var input_err = false;
  var error_detail = "";
  var index = parseInt(req.params.id);
  if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
    input_err = true;
    error_detail = "index";
  }

  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);
    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    check2FA(req, function(authresult) {
      if (authresult.status) {
        db.result('delete from technique where index = $1', index)
          .then(function(result) {
            if (result.rowCount > 0) {
              res.status(200)
                .json({
                  status: 'success',
                  result: result,
                  message: 'Removed ' + result.rowCount + ' tech'
                });
            } else {
              res.status(404)
                .json({
                  status: 'object not found',
                  result: result,
                  id: index
                });
            }
          })
          .catch(function(err) {
            return next(err);
          });
      } else {
        res.status(400)
          .json({
            status: 'fail',
            message: 'auth'
          });
      }
    });
  }
}

function getSchool(req, res, next) {
  var id = parseInt(req.params.id);
  db.one('select * from school where index = $1',
      id)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          id,
          message: 'Retrieved ' + id
        });
    })
    .catch(function(err) {
      res.status(404)
        .json({
          status: 'object not found',
          code: err.code,
          id: id,
          message: err.message
        });
    });
}

function getAllSchools(req, res, next) {
  // server.logger.debug('getAllSchools')
  db.any('select * from school order by name')
    .then(function(data) {
      if (data.length > 0) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            message: 'Retrieved ALL schools'
          });
      } else {
        res.status(404)
          .json({
            status: 'object not found',
            schoolid: schoolid
          });
      }
    })
    .catch(function(err) {
      server.logger.debug("catch:" + err);
      return next(err);
    });
}

function cuSchool(req, res, next) {
  server.logger.debug("Create or update school" + JSON.stringify(req.body));
  var input_err = false;
  var error_detail = "";
  // Make sure it doesn't already exist
  var name = req.body.name;
  if ((typeof name !== 'string') || (name.length < 1)) {
    input_err = true;
    error_detail = "name";
  }

  // Good inputs, update or create?
  var update = parseInt(req.body.update);
  if (!bjjt_utils.isNumeric(update) || (isNaN(update)) || (update < 0)) {
    update = 0;
  }

  // Check for index (update only)
  if (update) {
    // Index is required
    var index = parseInt(req.body.index);
    if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
      input_err = true;
      error_detail = "index";
    }
  }
  // Fail on input error
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    // Support update
    if (update) {
      check2FA(req, function(authresult) {
        if (authresult.status) {
          var strSQL = `update school
                      set name=$1 where index=$2`;
          db.none(
              strSQL, [name, index])
            .then(function(data) {
              res.status(200)
                .json({
                  status: 'success',
                  message: 'Updated school: ' + name,
                  index: index
                });
            })
            .catch(function(err) {
              server.logger.debug("catch:" + err);
              return next(err);
            });

        } else {
          res.status(400)
            .json({
              status: 'fail',
              message: 'auth'
            });
        }
      });
    } else {

      // Support Create
      db.oneOrNone(
          // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
          "SELECT index from school WHERE name ilike $1",
          name)
        .then(function(data) {
          if (data != null) {
            server.logger.debug("Exists: 1");
            input_err = true;
            error_detail = "Exists: " + JSON.stringify(data.index);
            res.status(400)
              .json({
                status: 'fail',
                data: error_detail,
                message: 'Duplicate'
              });

          } else {

            // does not exist, create it
            server.logger.debug("School doesn't exist, time to create " + name);

            if (input_err === true) {
              server.logger.debug("error_detail:" + error_detail);

              res.status(400)
                .json({
                  status: 'fail',
                  data: error_detail,
                  message: 'Bad input'
                });
            } else {
              check2FA(req, function(authresult) {
                if (authresult.status) {
                  var strSQL = "insert into school(createdate, name) " +
                    "values(CURRENT_TIMESTAMP, $1) " +
                    "RETURNING index";
                  db.one(
                      strSQL, [name])
                    .then(function(data) {
                      res.status(200)
                        .json({
                          status: 'success',
                          data: data.index,
                          message: 'Inserted one school: ' + name
                        });
                    })
                    .catch(function(err) {
                      server.logger.debug("catch:" + err);
                      return next(err);
                    });

                } else {
                  res.status(400)
                    .json({
                      status: 'fail',
                      message: 'auth'
                    });

                }
              });
            }
          }
        })
        .catch(function(err) {
          res.status(404)
            .json({
              status: 'object not found',
              code: err.code,
              id: id,
              message: err.message
            });
        });
    }
  }
}

function removeSchool(req, res, next) {
  server.logger.debug("Delete school" + JSON.stringify(req.params));
  var input_err = false;
  var error_detail = "";
  var index = parseInt(req.params.id);
  if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
    input_err = true;
    error_detail = "index";
  }

  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    check2FA(req, function(authresult) {
      if (authresult.status) {
        db.result('delete from school where index = $1', index)
          .then(function(result) {
            if (result.rowCount > 0) {
              res.status(200)
                .json({
                  status: 'success',
                  result: result,
                  message: 'Removed ' + index
                });
            } else {
              res.status(404)
                .json({
                  status: 'object not found',
                  result: result,
                  id: index
                });
            }
          })
          .catch(function(err) {
            return next(err);
          });

      } else {
        res.status(400)
          .json({
            status: 'fail',
            message: 'auth'
          });
      }
    });
  }
}


function getCourse(req, res, next) {
  var id = parseInt(req.params.id);
  db.one('select course.*, school.name as schoolname from course INNER JOIN school ON course.schoolid = school.index WHERE course.index = $1',
      id)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          id,
          message: 'Retrieved ' + id
        });
    })
    .catch(function(err) {
      res.status(404)
        .json({
          status: 'object not found',
          code: err.code,
          id: id,
          message: err.message
        });
    });
}


function getAllCourses(req, res, next) {
  var input_err = false;
  var error_detail = "";
  // Index is required
  var schoolid = parseInt(req.params.schoolid);
  if (!bjjt_utils.isNumeric(schoolid) || (isNaN(schoolid)) || (schoolid < 1)) {
    input_err = true;
    error_detail = "index";
  }
  // Fail on input error
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    db.any('select course.*, school.name as schoolname from course INNER JOIN school ON course.schoolid = school.index WHERE course.schoolid = $1 order by course.sequencenum', [schoolid])
      .then(function(data) {
        if (data.length > 0) {
          res.status(200)
            .json({
              status: 'success',
              data: data,
              message: 'Retrieved ALL courses'
            });
        } else {
          res.status(404)
            .json({
              status: 'object not found',
              schoolid: schoolid
            });
        }
      })
      .catch(function(err) {
        server.logger.debug("catch:" + err);
        return next(err);
      });
  }
}

function cuCourse(req, res, next) {
  server.logger.debug("Create or update course " + JSON.stringify(req.body));
  var input_err = false;
  var error_detail = "";
  // Make sure it doesn't already exist
  var name = req.body.name;
  if ((typeof name !== 'string') || (name.length < 1)) {
    input_err = true;
    error_detail = "name";
  }

  // Good inputs, update or create?
  var update = parseInt(req.body.update);
  if (!bjjt_utils.isNumeric(update) || (isNaN(update)) || (update < 0)) {
    update = 0;
  }

  // Check for index (update only)
  if (update) {
    // Index is required
    var index = parseInt(req.body.index);
    if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
      input_err = true;
      error_detail = "index";
    }
  }

  // schoolid is required
  var schoolid = parseInt(req.body.schoolid);
  if (!bjjt_utils.isNumeric(schoolid) || (isNaN(schoolid)) || (schoolid < 1)) {
    input_err = true;
    error_detail = "schoolid";
  }

  // sequencenum is not required
  var sequencenum = parseInt(req.body.sequencenum);
  if (!bjjt_utils.isNumeric(sequencenum) || (isNaN(sequencenum)) || (sequencenum < 1)) {
    sequencenum = 0;
  }
  // Fail on input error
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    // Support update
    if (update) {
      check2FA(req, function(authresult) {
        if (authresult.status) {

          var strSQL = `update course
                      set name=$1, schoolid=$2, sequencenum=$3 where index=$4`;
          db.none(
              strSQL, [name, schoolid, sequencenum, index])
            .then(function(data) {
              res.status(200)
                .json({
                  status: 'success',
                  message: 'Updated course: ' + name,
                  index: index
                });
            })
            .catch(function(err) {
              server.logger.debug("catch:" + err);
              return next(err);
            });
        } else {
          res.status(400)
            .json({
              status: 'fail',
              message: 'auth'
            });
        }
      });
    } else {

      // Support Create
      db.oneOrNone(
          // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
          "SELECT index from course WHERE name ilike $1",
          name)
        .then(function(data) {
          if (data != null) {
            server.logger.debug("Exists: 1");
            input_err = true;
            error_detail = "Exists: " + JSON.stringify(data.index);
            res.status(400)
              .json({
                status: 'fail',
                data: error_detail,
                message: 'Duplicate'
              });

          } else {
            // does not exist, create it
            server.logger.debug("course doesn't exist, time to create " + name);

            if (input_err === true) {
              server.logger.debug("error_detail:" + error_detail);

              res.status(400)
                .json({
                  status: 'fail',
                  data: error_detail,
                  message: 'Bad input'
                });
            } else {
              check2FA(req, function(authresult) {
                if (authresult.status) {
                  var strSQL = "insert into course(name, schoolid, sequencenum, createdate) " +
                    "values($1, $2, $3, CURRENT_TIMESTAMP) " +
                    "RETURNING index";
                  db.one(
                      strSQL, [name, schoolid, sequencenum])
                    .then(function(data) {
                      res.status(200)
                        .json({
                          status: 'success',
                          data: data.index,
                          message: 'Inserted one course: ' + name
                        });
                    })
                    .catch(function(err) {
                      server.logger.debug("catch:" + err);
                      return next(err);
                    });
                } else {
                  res.status(400)
                    .json({
                      status: 'fail',
                      message: 'auth'
                    });
                }
              });
            }
          }
        })
        .catch(function(err) {
          return next(err);
        });
    }
  }
}

function removeCourse(req, res, next) {
  var input_err = false;
  var error_detail = "";
  var index = parseInt(req.params.id);
  if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
    input_err = true;
    error_detail = "index";
  }

  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);
    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    check2FA(req, function(authresult) {
      if (authresult.status) {

        db.result('delete from course where index = $1', index)
          .then(function(result) {
            if (result.rowCount > 0) {
              res.status(200)
                .json({
                  status: 'success',
                  result: result,
                  message: 'Removed ' + result.rowCount + ' course'
                });
            } else {
              res.status(404)
                .json({
                  status: 'object not found',
                  result: result,
                  id: index
                });
            }
          })
          .catch(function(err) {
            return next(err);
          });
      } else {
        res.status(400)
          .json({
            status: 'fail',
            message: 'auth'
          });
      }
    });
  }
}


function getClass(req, res, next) {
  var id = parseInt(req.params.id);
  var input_err = false;
  var error_detail = "";
  if (!bjjt_utils.isNumeric(id) || (isNaN(id)) || (id < 1)) {
    input_err = true;
    error_detail = "id";
  }
  // Fail on input error
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    db.one(`select class.*, course.name as coursename, school.index as schoolid, school.name as schoolname
          from
          school INNER JOIN (
          class INNER JOIN
          course ON class.courseid = course.index)
          ON school.index = course.schoolid
          WHERE class.index = $1
          order by class.sequencenum`, [id])
      .then(function(data) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            id,
            message: 'Retrieved ' + id
          });
      })
      .catch(function(err) {
        res.status(404)
          .json({
            status: 'object not found',
            code: err.code,
            id: id,
            message: err.message
          });
      });
  }
}


function getAllClasses(req, res, next) {
  var input_err = false;
  var error_detail = "";
  // Index is required
  var courseid = parseInt(req.params.courseid);
  if (!bjjt_utils.isNumeric(courseid) || (isNaN(courseid)) || (courseid < 1)) {
    input_err = true;
    error_detail = "courseid";
  }
  // Fail on input error
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    db.any(`
      select class.*, course.name as coursename, school.name as schoolname, school.index as schoolid, 'class' as tag
      from
      school INNER JOIN (
      class INNER JOIN
      course ON class.courseid = course.index)
      ON school.index = course.schoolid
      WHERE class.courseid = $1
      order by class.sequencenum`,
        courseid)
      .then(function(data) {
        if (data.length > 0) {
          res.status(200)
            .json({
              status: 'success',
              data: data,
              message: 'Retrieved ALL classes'
            });
        } else {
          res.status(404)
            .json({
              status: 'object not found',
              courseid: courseid
            });
        }
      })
      .catch(function(err) {
        server.logger.debug("catch:" + err);
        return next(err);
      });
  }
}


function getAllClassesInSchool(req, res, next) {
  var input_err = false;
  var error_detail = "";
  // Index is required
  var schoolid = parseInt(req.params.schoolid);
  if (!bjjt_utils.isNumeric(schoolid) || (isNaN(schoolid)) || (schoolid < 1)) {
    input_err = true;
    error_detail = "schoolid";
  }
  // Fail on input error
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    db.any(`
      select class.*, course.name as coursename, school.name as schoolname, school.index as schoolid
      from
      school INNER JOIN (
      class INNER JOIN
      course ON class.courseid = course.index)
      ON school.index = course.schoolid
      WHERE school.index = $1
      order by class.name`,
        schoolid)
      .then(function(data) {
        if (data.length > 0) {
          res.status(200)
            .json({
              status: 'success',
              data: data,
              message: 'Retrieved ALL classes'
            });
        } else {
          res.status(404)
            .json({
              status: 'object not found',
              schoolid: schoolid
            });
        }
      })
      .catch(function(err) {
        server.logger.debug("catch:" + err);
        return next(err);
      });
  }
}

function cuClass(req, res, next) {
  server.logger.debug("Create or update class " + JSON.stringify(req.body));
  var input_err = false;
  var error_detail = "";
  // Make sure it doesn't already exist
  var name = req.body.name;
  if ((typeof name !== 'string') || (name.length < 1)) {
    input_err = true;
    error_detail = "name";
  }

  // Good inputs, update or create?
  var update = parseInt(req.body.update);
  if (!bjjt_utils.isNumeric(update) || (isNaN(update)) || (update < 0)) {
    update = 0;
  }

  // Check for index (update only)
  if (update) {
    // Index is required
    var index = parseInt(req.body.index);
    if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
      input_err = true;
      error_detail = "index";
    }
  }

  // courseid is required
  var courseid = parseInt(req.body.courseid);
  if (!bjjt_utils.isNumeric(courseid) || (isNaN(courseid)) || (courseid < 1)) {
    input_err = true;
    error_detail = "courseid";
  }

  // sequencenum is not required
  var sequencenum = parseInt(req.body.sequencenum);
  if (!bjjt_utils.isNumeric(sequencenum) || (isNaN(sequencenum)) || (sequencenum < 1)) {
    sequencenum = 0;
  }
  // Fail on input error
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    // Support update
    if (update) {
      check2FA(req, function(authresult) {
        if (authresult.status == true) {
          var strSQL = `update class
                      set name=$1, courseid=$2, sequencenum=$3 where index=$4`;
          db.none(
              strSQL, [name, courseid, sequencenum, index])
            .then(function(data) {
              res.status(200)
                .json({
                  status: 'success',
                  message: 'Updated class: ' + name,
                  index: index
                });
            })
            .catch(function(err) {
              server.logger.debug("catch:" + err);
              return next(err);
            });
        } else {
          res.status(400)
            .json({
              status: 'fail',
              message: 'auth'
            });
        }
      });

    } else {

      // Support Create
      db.oneOrNone(
          // Note, ~* is a case insensitive LIKE in postgresql, which is NOT standard SQL!
          "SELECT index from class WHERE name ilike $1 and courseid = $2", [name, courseid])
        .then(function(data) {
          if (data != null) {
            server.logger.debug("Exists: 1");
            input_err = true;
            error_detail = "Exists: " + JSON.stringify(data.index);
            res.status(400)
              .json({
                status: 'fail',
                data: error_detail,
                message: 'Duplicate'
              });

          } else {
            // does not exist, create it
            server.logger.debug("class doesn't exist, time to create " + name);

            if (input_err === true) {
              server.logger.debug("error_detail:" + error_detail);

              res.status(400)
                .json({
                  status: 'fail',
                  data: error_detail,
                  message: 'Bad input'
                });
            } else {
              check2FA(req, function(authresult) {
                if (authresult.status) {
                  var strSQL = "insert into class(name, courseid, sequencenum, createdate) " +
                    "values($1, $2, $3, CURRENT_TIMESTAMP) " +
                    "RETURNING index";
                  db.one(
                      strSQL, [name, courseid, sequencenum])
                    .then(function(data) {
                      res.status(200)
                        .json({
                          status: 'success',
                          data: data.index,
                          message: 'Inserted one class: ' + name
                        });
                    })
                    .catch(function(err) {
                      server.logger.debug("catch:" + err);
                      return next(err);
                    });
                } else {
                  res.status(400)
                    .json({
                      status: 'fail',
                      message: 'auth'
                    });
                }
              });
            }
          }
        })
        .catch(function(err) {
          return next(err);
        });
    }
  }
}

function removeClass(req, res, next) {
  var input_err = false;
  var error_detail = "";
  var index = parseInt(req.params.id);
  if (!bjjt_utils.isNumeric(index) || (isNaN(index)) || (index < 1)) {
    input_err = true;
    error_detail = "index";
  }

  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);
    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    check2FA(req, function(authresult) {
      if (authresult.status) {

        db.result('delete from class where index = $1', index)
          .then(function(result) {
            if (result.rowCount > 0) {
              res.status(200)
                .json({
                  status: 'success',
                  result: result,
                  message: 'Removed ' + result.rowCount + ' class'
                });
            } else {
              res.status(404)
                .json({
                  status: 'object not found',
                  result: result,
                  id: index
                });
            }
          })
          .catch(function(err) {
            return next(err);
          });
      } else {
        res.status(400)
          .json({
            status: 'fail',
            message: 'auth'
          });
      }
    });
  }
}

function getTechsInClass(req, res, next) {
  server.logger.debug("Get techs in class " + JSON.stringify(req.params));
  var input_err = false;
  var error_detail = "";
  // Index is required
  var classid = parseInt(req.params.classid);
  if (!bjjt_utils.isNumeric(classid) || (isNaN(classid)) || (classid < 1)) {
    input_err = true;
    error_detail = "classid";
  }
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);
    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    db.any(`
      select classtech.*, class.name as classname, technique.name as techname, course.name as coursename, course.index as courseid, 'tech' as tag
      from
      technique INNER JOIN (
      course INNER JOIN (
      class INNER JOIN
      classtech ON classtech.classid = class.index)
      ON course.index = classtech.classid)
      ON technique.index = classtech.techid
      WHERE classtech.classid = class.index AND technique.index = classtech.techid
      AND class.index = $1
      order by classtech.sequencenum`,
        classid)
      .then(function(data) {
        if (data.length > 0) {
          res.status(200)
            .json({
              status: 'success',
              data: data,
              message: 'Retrieved ALL classtechs'
            });
        } else {
          res.status(404)
            .json({
              status: 'object not found',
              id: classid
            });
        }
      })
      .catch(function(err) {
        server.logger.debug("catch:" + err);
        return next(err);
      });
  }
}

function getAllClassesWithTech(req, res, next) {
  server.logger.debug("Get all classes with tech " + JSON.stringify(req.params));
  var input_err = false;
  var error_detail = "";
  // Index is required
  var techid = parseInt(req.params.techid);
  if (!bjjt_utils.isNumeric(techid) || (isNaN(techid)) || (techid < 1)) {
    input_err = true;
    error_detail = "techid";
  }
  var schoolid = parseInt(req.params.schoolid);
  if (!bjjt_utils.isNumeric(schoolid) || (isNaN(schoolid)) || (schoolid < 1)) {
    input_err = true;
    error_detail = "schoolid";
  }
  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);
    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    db.any(`
      select classtech.*, class.index as classid, school.name as schoolname, course.name as coursename, course.index as courseid, class.name as classname, technique.name as techname
      from school,
      technique INNER JOIN (
      course INNER JOIN (
      class INNER JOIN
      classtech ON classtech.classid = class.index)
      ON course.index = class.courseid)
      ON technique.index = classtech.techid
      WHERE classtech.classid = class.index AND technique.index = classtech.techid
      AND technique.index = $1
      AND school.index = $2
      order by class.name`, [techid, schoolid])
      .then(function(data) {
        if (data.length > 0) {
          res.status(200)
            .json({
              status: 'success',
              data: data,
              message: 'Retrieved ALL classes with tech ' + techid
            });
        } else {
          res.status(404)
            .json({
              status: 'object not found',
              id: techid
            });
        }
      })
      .catch(function(err) {
        server.logger.debug("catch:" + err);
        return next(err);
      });
  }
}

function addTechsToClass(req, res, next) {
  server.logger.debug("Add techs to class " + JSON.stringify(req.body));
  var input_err = false;
  var error_detail = "";
  // Index is required
  var classid = parseInt(req.body.classid);
  if (!bjjt_utils.isNumeric(classid) || (isNaN(classid)) || (classid < 1)) {
    input_err = true;
    error_detail = "classid";
  }

  // techs array is required
  // It is an array of [{techid, sequencenum}]
  var techs = req.body.techs;
  if (techs.length < 1) {
    input_err = true;
    error_detail = "techs";
  }


  if (input_err === true) {
    server.logger.debug("error_detail:" + error_detail);

    res.status(400)
      .json({
        status: 'fail',
        data: error_detail,
        message: 'Bad input'
      });
  } else {
    check2FA(req, function(authresult) {
      if (authresult.status) {

        var loopInsert, techid, sequencenum;

        for (loopInsert = 0; loopInsert < techs.length; loopInsert++) {
          techid = techs[loopInsert].techid;
          sequencenum = techs[loopInsert].sequencenum;

          var strSQL = `insert into classtech(classid, techid, sequencenum, createdate)
            values($1, $2, $3, CURRENT_TIMESTAMP)`;
          db.one(
              strSQL, [classid, techid, sequencenum])
            .then(function(data) {
              res.status(200)
                .json({
                  status: 'success',
                  message: 'Inserted one classtech: ' + classid + ':' + techid + '(' + sequencenum + ')'
                });
            })
            .catch(function(err) {
              res.status(400)
                .json({
                  status: 'fail',
                  detail: err.detail,
                  message: err.message
                });
            });
        }
      } else {
        res.status(400)
          .json({
            status: 'fail',
            message: 'auth'
          });
      }
    });
  }
}

function updateTechsInClass(req, res, next) {}

function removeTechsFromClass(req, res, next) {}

function removeTechFromClass(req, res, next) {}
