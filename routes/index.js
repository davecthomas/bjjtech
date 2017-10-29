// routes/index.js

const express = require('express');
const passport = require('passport');
const router = express.Router();

module.exports = function(router) {
  // Perform the login
  router.get(
    '/login',
    passport.authenticate('auth0', {
      clientID: process.env.AUTH0_CLIENT_ID,
      domain: process.env.AUTH0_DOMAIN,
      redirectUri: process.env.AUTH0_CALLBACK_URL,
      audience: 'https://' + process.env.AUTH0_DOMAIN + '/userinfo',
      responseType: 'code',
      scope: 'openid'
    }),
    function(req, res) {
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
      failureRedirect: '/'
    }),
    function(req, res) {
      res.redirect(req.session.returnTo || '/');
    }
  );
};
