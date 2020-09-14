// routes/index.js

const express = require('express');
const passport = require('passport');
var ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn();
var root = require('./root'); // root.js has our web logic

const router = express.Router();
var bjjt_utils = require('../public/dist/js/bjjt_utils.js');

module.exports = function(router) {
  // Perform the login
  router.get(
    '/login',
    passport.authenticate('auth0', {
      // clientID: process.env.AUTH0_CLIENT_ID,
      // domain: process.env.AUTH0_DOMAIN,
      // redirectUri: process.env.AUTH0_CALLBACK_URL,
      // audience: 'https://' + process.env.AUTH0_DOMAIN + '/userinfo',
      // responseType: 'code',
      // scope: 'openid profile'
    }),
    function(req, res) {
      req.app.locals.bjjtech.server.logger.info('Login ' + process.env.AUTH0_CALLBACK_URL);
      res.redirect('/');
    }
  );

  // Perform session logout and redirect to homepage
  router.get('/logout', (req, res) => {
    req.logout();
    res.redirect('/');
  });


  // Perform the final stage of authentication and redirect to '/'
  router.get(
    '/callback',
    passport.authenticate('auth0', {
      failureRedirect: '/login'
    }),
    function(req, res) {
      if (!req.user) {
        throw new Error('user null');
      }

      req.user.authenticated = true;
      req.app.locals.bjjtech.server.logger.info('Login callback user : ' + JSON.stringify(req.user));
      res.redirect(req.session.returnTo || '/index');
    }
  );

  router.get('/user', function(req, res, next) {
    var api_url = bjjt_utils.getAPI(req);
    var root_url = bjjt_utils.getRoot(req);
    req.app.locals.bjjtech.server.logger.info("USER : " + JSON.stringify(req.user));

    res.render('pages/user', {
      user: req.user,
      userProfile: JSON.stringify(req.user, null, '  '),
      api_url: api_url,
      root_url: root_url
    });
  });
};
