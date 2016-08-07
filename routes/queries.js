// http://mherman.org/blog/2016/03/13/designing-a-restful-api-with-node-and-postgres/#.V6OlC5MrJE4
var app = require('../api_server');
var promise = require('bluebird');

var options = {
  // Initialization Options
  promiseLib: promise
};

var pgp = require('pg-promise')(options);
// var connectionString = 'postgres://uhysicyepxoqup:y4k-5ixpJulBVtwciNexZmuAvJ@ec2-54-163-251-104.compute-1.amazonaws.com:5432/d2fa0lq37cnebt';
// var connectionString = 'postgres://ec2-54-163-251-104.compute-1.amazonaws.com:5432/d2fa0lq37cnebt?sslmode=require&user=uhysicyepxoqup&password=y4k-5ixpJulBVtwciNexZmuAvJ';
// var connectionString = 'postgres://localhost:5432/bjjtech';
var connectionString = {
    user: "uhysicyepxoqup",
    password: "y4k-5ixpJulBVtwciNexZmuAvJ",
    database: "d2fa0lq37cnebt",
    port: 5432,
    host: "ec2-54-163-251-104.compute-1.amazonaws.com",
    ssl: true
};
var db = pgp(connectionString);

// add query functions

module.exports = {
  getAllTech: getAllTech,
  getTechFromStr: getTechFromStr,
  getSingleTech: getSingleTech,
  createTech: createTech,
  updateTech: updateTech,
  removeTech: removeTech
};

function getAllTech(req, res, next) {
  db.any('select * from technique')
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL tech'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function getTechFromStr(req, res, next) {
  var strSearch = parseInt(req.params.str);
  db.any("select * from technique where name LIKE '%' || $1 || '%' OR setup LIKE '%' || $1 || '%' OR details LIKE '%' || $1 || '%'", strSearch)
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved tech with str ' + strSearch
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function getSingleTech(req, res, next) {
  var techniqueID = parseInt(req.params.id);
  db.one('select * from technique where index = $1', techniqueID)
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ONE tech'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function updateTech(req, res, next) {
  db.none('update technique set type=$1, topic=$2, name=$3, setup=$4, details=$5, credit=$6, sport=$7 , startingpos=$8 , endingpos=$9 , opponentstartingpos=$10, skilllevel=$11, lastteachdate=$12 where index=$5',
    [req.body.name, req.body.breed, parseInt(req.body.age),
      req.body.sex, parseInt(req.params.index)])
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Updated technique'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function createTech(req, res, next) {
  req.body.age = parseInt(req.body.age);
  db.none('insert into technique(type, topic, name, setup, details, credit, index, sport, startingpos, endingpos, imageurl, numimages, videoid, opponentstartingpos, skilllevel, lastteachdate, rating, ratings)' +
      'values(${type}, ${topic}, ${name}, ${setup}, ${details}, ${credit}, ${index}, ${sport}, ${startingpos}, ${endingpos}, ${imageurl}, ${numimages}, ${videoid}, ${opponentstartingpos}, ${skilllevel}, ${lastteachdate})',
    req.body)
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Inserted one tech'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function removeTech(req, res, next) {
  var pupID = parseInt(req.params.id);
  db.result('delete from technique where index = $1', pupID)
    .then(function (result) {
      /* jshint ignore:start */
      res.status(200)
        .json({
          status: 'success',
          message: 'Removed ${result.rowCount} tech'
        });
      /* jshint ignore:end */
    })
    .catch(function (err) {
      return next(err);
    });
}
