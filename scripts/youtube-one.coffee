# Description:
#   Messing around with the YouTube API.
#
# Commands:
#   hubot youtube1 <query> - Searches YouTube for the query and returns the first matching video embed link.
module.exports = (robot) ->
  robot.respond /(youtube1|yt1) (.*)/i, (msg) ->
    query = msg.match[2]
    robot.http("http://gdata.youtube.com/feeds/api/videos")
      .query({
        orderBy: "relevance"
        'max-results': 2
        alt: 'json'
        q: query
      })
      .get() (err, res, body) ->
        videos = JSON.parse(body)
        videos = videos.feed.entry

        unless videos?
          msg.send "No video results for \"#{query}\""
          return

        #XXX: Since the first video is always a video showing devicesupport info, we 
        # would pick the 2nd one.
        video  = videos[1]
        video.link.forEach (link) ->
          if link.rel is "alternate" and link.type is "text/html"
            msg.send link.href

