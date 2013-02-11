


// // Set up a collection to contain technique information. On the server,
// it is backed by a MongoDB collection named "techniques".

Techniques = new Meteor.Collection("techniques");

if (Meteor.isClient) {
  Template.leaderboard.techniques = function () {
    return Techniques.find({}, {sort: {score: -1, name: 1}});
  };

  Template.leaderboard.selected_name = function () {
    var technique = Techniques.findOne(Session.get("selected_technique"));
    return technique && technique.name;
  };

  Template.technique.selected = function () {
    return Session.equals("selected_technique", this._id) ? "selected" : '';
  };

  Template.leaderboard.events({
    'click input.inc': function () {
      Techniques.update(Session.get("selected_technique"), {$inc: {score: 5}});
    }
  });

  Template.technique.events({
    'click': function () {
      Session.set("selected_technique", this._id);
    }
  });
}

// On server startup, create some techniques if the database is empty.
if (Meteor.isServer) {
  Meteor.startup(function () {
         
      
    if (Techniques.find().count() === 0) {
      var names = ["No techniques found. Mongo problem!"];
      for (var i = 0; i < names.length; i++)
        Techniques.insert({name: names[i], score: Math.floor(Math.random()*10)*5});
    }
  });
}
