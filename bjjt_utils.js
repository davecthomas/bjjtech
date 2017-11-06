var bluebird = require('bluebird');
var options = {
  // Initialization Options
  promiseLib: bluebird
};

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

var pgp = require('pg-promise')(initOptions);

module.exports = {

  autoExpandSectionLimit: 5,

  ensureAuthenticated: function(req, res, next) {
    req.app.locals.bjjtech.server.logger.info("ensureAuth: ");
    if (req.isAuthenticated()) {
      return next();
    }
    res.redirect('/login');
  },

  replaceAll: function(str, search, replacement) {
    return str.replace(new RegExp(search, 'g'), replacement);
  },

  isNumeric: function(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
  },


  replaceAllNumlist: function(str, replacement) {
    re = new RegExp(/\d+(\.)/g);
    return str.replace(re, replacement);
  },

  cleanDetailText: function(detailIn) {
    var details = replaceAllNumlist(detailIn,
      '<br><br><i class="fa fa-chevron-circle-right"></i>&nbsp;');
    details = replaceAll(details, "\n", "");
    if (details.indexOf('<br><br>') == 0) {
      details = details.replace('<br><br>', '');
    }
    return details;
  },

  fixQuotes: function(str) {
    return str.replace(/'/g, '&rsquo;');
  },

  escapeQuotes: function(str) {
    return str.replace(/(['"])/g, "\\$1");
  },

  insertAt: function(src, index, str) {
    return src.substr(0, index) + str + src.substr(index)
  },

  getAPI: function(req) {
    var api_url = process.env.BJJT_API_ROOT_URL + '/api/';
    if (req.app.get('env') === 'development') {
      api_url = process.env.BJJT_API_ROOT_URL + ":" + req.app.get('port') + '/api/';
      // req.app.locals.bjjtech.server.logger.info( 'Dev environment API url set to ' +  api_url );
    }
    return api_url;
  },

  getRoot: function(req) {
    var root_url = process.env.BJJT_API_ROOT_URL + "/";
    if (req.app.get('env') === 'development') {
      root_url = process.env.BJJT_API_ROOT_URL + ":" + req.app.get('port') + "/";
      req.app.locals.bjjtech.server.logger.info('Dev environment root url set to ' + root_url);
    }
    return root_url;
  },

  getConnection: function(server) {
    var connectionString;

    if (server.app.get('env') === 'development') {
      server.logger.debug('Dev DB connection : user: ' + process.env.DB_user + ', host: ' + process.env.DB_host + ':' + process.env.DB_port + ", ssl: " + process.env.DB_ssl);
      connectionString = {
        user: process.env.DB_user,
        password: process.env.DB_password,
        database: process.env.DB_database,
        port: process.env.DB_port,
        host: process.env.DB_host,
        ssl: false
      };
    } else {
      server.logger.info('Production DB connection');
      connectionString =
        'postgres://uhysicyepxoqup:y4k-5ixpJulBVtwciNexZmuAvJ@ec2-54-163-251-104.compute-1.amazonaws.com:5432/d2fa0lq37cnebt';
    }
    // var connectionString = 'postgres://localhost:5432/bjjtech';
    var db = pgp(connectionString);
    return db;
  }

};
