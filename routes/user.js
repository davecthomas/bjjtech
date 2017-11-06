var server = require('../server');
var bjjt_utils = require('../bjjt_utils');


// add query functions

module.exports = {
  isUser: isUser

};

var db = bjjt_utils.getConnection(server);

function isUser(req, res, next) {
  var userNick = req.params.nick;
  db.one('select * from users where login = $1',
      userNick)
    .then(function(data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          nick: userNick,
          message: 'Retrieved user'
        });
    })
    .catch(function(err) {
      res.status(404)
        .json({
          status: 'user not found',
          code: err.code,
          nick: userNick,
          message: err.message
        });
    });
}
