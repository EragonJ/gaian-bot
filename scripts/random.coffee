# Description:
#   Messing around with the YouTube API.
#
# Commands:
#   hubot random me <Number> - would randomly choose one number from it (> 0)
#   hubot random me nameA, nameB, nameC - would randomly choose one name
module.exports = (robot) ->
  robot.respond /(random|ran|rand)( me)? (.*)/i, (msg) ->
    query = msg.match[3]
    if not isNaN(parseInt(query, 10))
      query = parseInt(query, 10)
      msg.send (Math.floor(Math.random() * 100) % query) + 1
    else
      # a, b, c, d => we would choose one
      names = query.split(',')
      randomIndex = Math.floor(Math.random() * 100) % names.length
      msg.send names[randomIndex].trim()
