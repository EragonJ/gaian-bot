# Description:
#   Pick one random user.
#
# Commands:
#   hubot pick - Pick one user randomly.

module.exports = (robot) ->
  robot.respond /pick$/i, (msg) ->
    users = [];
    for own key, user of robot.brain.data.users
      users.push(user.name);

    random = Math.floor(Math.random() * users.length);
    msg.send users[random] + " is the winner!!!"
