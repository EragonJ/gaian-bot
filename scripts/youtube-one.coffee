# Description:
#   Messing around with the YouTube API.
#
# Commands:
#   hubot youtube1 <query> - Searches YouTube for the query and returns the first matching video embed link.
module.exports = (robot) ->
  robot.respond /(youtube1|yt1) (.*)/i, (msg) ->
    query = msg.match[2]
    robot.http("https://www.googleapis.com/youtube/v3/search")
      .query({
        part: "snippet"
        order: "ViewCount",
        maxResults: "1",
        q: query,
        key: "{USE-YOUR-KEY}"
      })
      .get() (err, res, body) ->
        videos = JSON.parse(body).items

        unless videos?
          msg.send "No video results for \"#{query}\""
          return

        youtubeViewLink = "https://www.youtube.com/watch?v=";

        video  = videos[0]
        msg.send (youtubeViewLink + video.id.videoId)
