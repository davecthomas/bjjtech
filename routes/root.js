var request = require('request');


var queries = require('./queries');
var bjjt_utils = require('../bjjt_utils');


// add query functions

module.exports = {
  getPrivacy: getPrivacy,
  getIndex: getIndex,
  getHeader: getHeader,
  newTech: newTech,
  updateTech: updateTech,
  getAllTech: getAllTech,
  getTechFromStr: getTechFromStr,
  getTech: getTech,

  getSchool: getSchool,
  getCourse: getCourse,
  getClass: getClass

};


function getPrivacy(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);

  res.render('pages/privacy', {
    api_url: api_url,
    root_url: root_url
  });
};


// define the home page route
function getIndex(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  request(api_url + 'tech/topicsextended', function(error, response, body) {
    if (!error && response.statusCode == 200) {
      req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);
      res.render('pages/index', {
        api_url: api_url,
        root_url: root_url,
        response: body
      });
    }
  })
};

function getHeader(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  res.render('pages/gettechfromstr', {
    api_url: api_url,
    root_url: root_url
  });
};

function getAllTech(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  res.render('pages/getalltech', {
    api_url: api_url,
    root_url: root_url
  });
};

function newTech(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);

  request(api_url + 'tech/topics', function(error, response, topics) {
    if (!error && response.statusCode == 200) {
      req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);

      request(api_url + 'tech/levels', function(error, response, levels) {
        if (!error && response.statusCode == 200) {
          req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);



          request(api_url + 'tech/sports', function(error, response, sports) {
            if (!error && response.statusCode == 200) {
              req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);



              request(api_url + 'tech/positions', function(error, response, positions) {
                if (!error && response.statusCode == 200) {
                  req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);


                  request(api_url + 'tech/types', function(error, response, types) {
                    if (!error && response.statusCode == 200) {
                      req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);

                      res.render('pages/newtech', {
                        api_url: api_url,
                        root_url: root_url,
                        topics: topics,
                        levels: levels,
                        sports: sports,
                        positions: positions,
                        types: types,
                        response: null,
                        id: 0,
                        update: false
                      });
                    }
                  })
                }
              })
            }
          })
        }
      })
    }
  })

};

function updateTech(req, res) {
  req.app.locals.bjjtech.server.logger.info('updateTech');
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  var searchStr = "";
  var techniqueID = 0; // See if this is coming from old ASP-style link ...asp?id=100
  if (!bjjt_utils.isNumeric(req.query.id) || (isNaN(req.query.id))) {
    if (bjjt_utils.isNumeric(req.params.id)) {
      techniqueID = parseInt(req.params.id); // Coming from new-style format
    }
  }
  req.app.locals.bjjtech.server.logger.info('updateTech' + techniqueID);
  request(api_url + 'tech/topics', function(error, response, topics) {
    if (!error && response.statusCode == 200) {
      req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);

      request(api_url + 'tech/levels', function(error, response, levels) {
        if (!error && response.statusCode == 200) {
          req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);



          request(api_url + 'tech/sports', function(error, response, sports) {
            if (!error && response.statusCode == 200) {
              req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);



              request(api_url + 'tech/positions', function(error, response, positions) {
                if (!error && response.statusCode == 200) {
                  req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);


                  request(api_url + 'tech/types', function(error, response, types) {
                    if (!error && response.statusCode == 200) {
                      req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);

                      request(api_url + 'tech/' + techniqueID, function(error, response, body) {
                        if (!error && response.statusCode == 200) {
                          // Once we render a page, we don't have access to server-side functionality,
                          // So we clean up specific data prior to hand-off.
                          var tech = JSON.parse(body);
                          if ((tech.status === 'success') && (techniqueID > 0)) {
                            res.render('pages/newtech', {
                              api_url: api_url,
                              root_url: root_url,
                              topics: topics,
                              levels: levels,
                              sports: sports,
                              positions: positions,
                              types: types,
                              response: bjjt_utils.fixQuotes(body), // We need to convert ' to &rsquo;
                              update: true,
                              id: techniqueID,
                              title: bjjt_utils.escapeQuotes(tech.data.name)
                            });
                          }
                        }
                      })
                    }
                  })
                }
              })
            }
          })
        }
      })
    }
  });
};


function getTech(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  var searchStr = "";
  var techniqueID = 0; // See if this is coming from old ASP-style link ...asp?id=100
  if (!bjjt_utils.isNumeric(req.query.id) || (isNaN(req.query.id))) {
    if (bjjt_utils.isNumeric(req.params.id)) {
      techniqueID = parseInt(req.params.id); // Coming from new-style format
    }
  } else {
    techniqueID = parseInt(req.query.id);
    req.app.locals.bjjtech.server.logger.info('YouTube tech/tech-detail.asp?id= ' + techniqueID);
  }

  if (techniqueID < 1) {
    res.render('pages/500', {
      api_url: api_url,
      root_url: root_url,
      error: {
        status: 'Error',
      },
      message: "Not happening today, brah.",
      verbose: false
    });

  } else {

    if ((req.query.search) && (req.query.search.length > 0)) {
      searchStr = req.query.search;
    }

    request(api_url + 'tech/' + techniqueID, function(error, response, body) {
      var tech = JSON.parse(body);
      if ((tech.status === 'success') && (techniqueID > 0)) {
        res.render('pages/gettech', {
          api_url: api_url,
          root_url: root_url,
          searchparam: searchStr,
          response: bjjt_utils.fixQuotes(body), // We need to convert ' to &rsquo;
          id: techniqueID,
          title: bjjt_utils.escapeQuotes(tech.data.name)
        });
      } else {
        res.render('pages/500', {
          api_url: api_url,
          root_url: root_url,
          error: error,
          message: "Not happening today, brah.",
          verbose: false
        });
      }
    })
  }
};

function getTechFromStr(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  var search = "";
  if (req.params.str.length > 0) {
    search = req.params.str;
  }
  request(api_url + 'tech/text/' + search, function(error, response, body) {
    if (!error && response.statusCode == 200) {
      res.render('pages/gettechfromstr', {
        api_url: api_url,
        root_url: root_url,
        response: body
      });
    }
  })

};

function getSchool(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  var searchStr = "";
  var id = 0;
  if (!bjjt_utils.isNumeric(req.query.id) || (isNaN(req.query.id))) {
    if (bjjt_utils.isNumeric(req.params.id)) {
      id = parseInt(req.params.id);
    }
  }
  if ((req.query.search) && (req.query.search.length > 0)) {
    searchStr = req.query.search;
  }
  request(api_url + 'courses/' + id, function(error, response, courses) {
    if (!error) {
      if (response.statusCode == 404) {
        courses = null; // No classes in in class is ok
      }
      if (response.statusCode == 200) {
        req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);
      }
      request(api_url + 'school/' + id, function(error, response, body) {
        if (!error && response.statusCode == 200) {
          var school = JSON.parse(body);
          res.render('pages/getschool', {
            api_url: api_url,
            root_url: root_url,
            searchparam: searchStr,
            school: bjjt_utils.fixQuotes(body), // We need to convert ' to &rsquo;
            id: id,
            title: bjjt_utils.escapeQuotes(school.data.name),
            courses: courses,
            autoExpandSectionLimit: bjjt_utils.autoExpandSectionLimit
          });
        }
      })

    }
  })
}

function getCourse(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  var searchStr = "";
  var id = 0;
  if (!bjjt_utils.isNumeric(req.query.id) || (isNaN(req.query.id))) {
    if (bjjt_utils.isNumeric(req.params.id)) {
      id = parseInt(req.params.id);
    }
  }
  if ((req.query.search) && (req.query.search.length > 0)) {
    searchStr = req.query.search;
  }
  request(api_url + 'classes/' + id, function(error, response, classes) {
    if (!error) {
      if (response.statusCode == 404) {
        classes = null; // No classes in in class is ok
      }
      if (response.statusCode == 200) {
        req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);
      }
      request(api_url + 'course/' + id, function(error, response, body) {
        if (!error && response.statusCode == 200) {
          var course = JSON.parse(body);
          res.render('pages/getcourse', {
            api_url: api_url,
            root_url: root_url,
            course: body,
            searchparam: searchStr,
            response: bjjt_utils.fixQuotes(body), // We need to convert ' to &rsquo;
            id: id,
            title: bjjt_utils.escapeQuotes(course.data.name),
            classes: classes,
            autoExpandSectionLimit: bjjt_utils.autoExpandSectionLimit
          });
        }
      })

    }
  })
}

function getClass(req, res) {
  var api_url = bjjt_utils.getAPI(req);
  var root_url = bjjt_utils.getRoot(req);
  var searchStr = "";
  var classid = 0;
  if (!bjjt_utils.isNumeric(req.query.id) || (isNaN(req.query.id))) {
    if (bjjt_utils.isNumeric(req.params.id)) {
      classid = parseInt(req.params.id);
    }
  }
  if ((req.query.search) && (req.query.search.length > 0)) {
    searchStr = req.query.search;
  }
  request(api_url + 'classtech/' + classid, function(error, response, classtech) {
    if (!error) {
      var techs;
      if (response.statusCode == 404) {
        techs = null; // No techs in class is ok
      }
      if (response.statusCode == 200) {
        techs = classtech;
      }
      req.app.locals.bjjtech.server.logger.info('Response' + response.statusCode);
      request(api_url + 'class/' + classid, function(error, response, body) {
        if (!error && response.statusCode == 200) {
          var class_parsed = JSON.parse(body);
          res.render('pages/getclass', {
            api_url: api_url,
            root_url: root_url,
            classdata: body,
            searchparam: searchStr,
            response: bjjt_utils.fixQuotes(body), // We need to convert ' to &rsquo;
            id: classid,
            title: bjjt_utils.escapeQuotes(class_parsed.data.name),
            classtech: techs,
            autoExpandSectionLimit: bjjt_utils.autoExpandSectionLimit
          });
        }
      })

    }
  })
}

// This is never called but useful in debugging logic in the footer, if needed
/*
exports.footer = function(req, res) {
  res.render('pages/footer');
};*/
