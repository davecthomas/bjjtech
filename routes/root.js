var request = require('request');

function getAPI(req) {
  var api_url = process.env.BJJT_API_ROOT_URL + '/api/';
  if (req.app.get('env') === 'development') {
    api_url = process.env.BJJT_API_ROOT_URL + ":" + req.app.get('port') + '/api/';
    // req.app.locals.bjjtech.server.logger.info( 'Dev environment API url set to ' +  api_url );
  }
  return api_url;
}

function getRoot(req) {
  var root_url = process.env.BJJT_API_ROOT_URL + "/";
  if (req.app.get('env') === 'development') {
    root_url = process.env.BJJT_API_ROOT_URL + ":" + req.app.get('port') + "/";
    req.app.locals.bjjtech.server.logger.info('Dev environment root url set to ' + root_url);
  }
  return root_url;
}

var queries = require('./queries');
var bjjt_utils = require('../bjjt_utils');

// add query functions

module.exports = {
  getIndex: getIndex,
  getHeader: getHeader,
  newTech: newTech,
  updateTech: updateTech,
  getAllTech: getAllTech,
  getTechFromStr: getTechFromStr,
  getTech: getTech,

  getClass: getClass

};

// define the home page route
function getIndex(req, res) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);
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
  var api_url = getAPI(req);
  var root_url = getRoot(req);
  res.render('pages/gettechfromstr', {
    api_url: api_url,
    root_url: root_url
  });
};

function getAllTech(req, res) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);
  res.render('pages/getalltech', {
    api_url: api_url,
    root_url: root_url
  });
};

function newTech(req, res) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);

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
  var api_url = getAPI(req);
  var root_url = getRoot(req);
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
  var api_url = getAPI(req);
  var root_url = getRoot(req);
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
  var api_url = getAPI(req);
  var root_url = getRoot(req);
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

function getClass(req, res) {
  var api_url = getAPI(req);
  var root_url = getRoot(req);
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
  request(api_url + 'class/' + classid, function(error, response, body) {
    if (!error && response.statusCode == 200) {
      var classresponse = JSON.parse(body);
      res.render('pages/getclass', {
        api_url: api_url,
        root_url: root_url,
        response: body,
        searchparam: searchStr,
        response: bjjt_utils.fixQuotes(body), // We need to convert ' to &rsquo;
        id: classid,
        title: bjjt_utils.escapeQuotes(classresponse.data.name)
      });
    }
  })
}

// This is never called but useful in debugging logic in the footer, if needed
/*
exports.footer = function(req, res) {
  res.render('pages/footer');
};*/
