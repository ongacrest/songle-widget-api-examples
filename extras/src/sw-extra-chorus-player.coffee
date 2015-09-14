###
  @author Takahiro INOUE <takahiro.inoue@aist.go.jp>
  @license Songle Widget API Examples

  Visit http://songle.jp/info/Credit.html OR http://widget.songle.jp/docs/v1 for documentation.
  Copyright (c) 2015 National Institute of Advanced Industrial Science and Technology (AIST)

  Distributed under the terms of the MIT license only for non-commercial purposes.
  http://www.opensource.org/licenses/mit-license.html

  This notice shall be included in all copies or substantial portions of this Songle Widget API Examples.
  If you are interested in commercial use of Songle Widget API, please contact "songle-ml@aist.go.jp".
###
window.__swExtra__ ?= {}

###
  @function
  @see https://developers.google.com/youtube/v3/docs/search/list
###
__swExtra__.searchYouTube =
  (options = {}) ->
    options.key             ?= "AIzaSyBA9OMeI6z4ByZZf8v4H3xFxXJ893BAkiE"
    options.maxResults      ?= "50"
    options.pageToken       ?= ""
    options.part            ?= "id"
    options.q               ?= "AIST VocaListener"
    options.regionCode      ?= "JP"
    options.type            ?= "video"
    options.videoCategoryId ?= "10"
    options.videoDuration   ?= "short"
    options.videoEmbeddable ?= "true"

    xhrRequest =
      $.getJSON "https://www.googleapis.com/youtube/v3/search?" +
        "key"             + "=" + encodeURIComponent(options.key)             + "&" +
        "maxResults"      + "=" + encodeURIComponent(options.maxResults)      + "&" +
        "pageToken"       + "=" + encodeURIComponent(options.pageToken)       + "&" +
        "part"            + "=" + encodeURIComponent(options.part)            + "&" +
        "q"               + "=" + encodeURIComponent(options.q)               + "&" +
        "regionCode"      + "=" + encodeURIComponent(options.regionCode)      + "&" +
        "type"            + "=" + encodeURIComponent(options.type)            + "&" +
        "videoCategoryId" + "=" + encodeURIComponent(options.videoCategoryId) + "&" +
        "videoDuration"   + "=" + encodeURIComponent(options.videoDuration)   + "&" +
        "videoEmbeddable" + "=" + encodeURIComponent(options.videoEmbeddable)

    xhrRequest.done (result) ->
      options.pageToken = result.prevPageToken
      options.pageToken = result.nextPageToken

      for item in result.items
        options.__urls__ ?= []
        options.__urls__.push("https://www.youtube.com/watch?v=#{ item.id.videoId }")

      if(options.pageToken)
        __swExtra__.searchYouTube(options)
      else
        options.onComplete &&
        options.onComplete(options.__urls__)

###
  @function
###
__swExtra__.startPlaylistFromRepeatSegment =
  (urls) ->
    url = urls.shift()

    songleWidgetElement =
      SongleWidgetAPI.createSongleWidgetElement
        api: "songle-widget-api-example#{ __swExtra__.random() }"
        url: url
        songAutoPlay: true
        songAutoLoop: true
        songStartAt: "chorus"
        onReady:
          (songleWidget) ->
            __swExtra__.initializeReadyModule songleWidget,
              force: true

            chorusSegment = songleWidget.song.scene.repeatSegments[ 0 ] || { duration: SongleWidgetAPI.secondsToMilliseconds(30) }
            repeatSegment = songleWidget.song.scene.repeatSegments[ 1 ] || { duration: SongleWidgetAPI.secondsToMilliseconds(30) }

            if chorusSegment.duration < repeatSegment.duration
              setTimeout ->
                songleWidget.remove()
              , chorusSegment.duration
            else
              setTimeout ->
                songleWidget.remove()
              , repeatSegment.duration

            songleWidget.on "remove",
              ->
                __swExtra__.startPlaylistFromRepeatSegment(urls)

            songleWidget.on "finish",
              ->
                songleWidget.remove()

    document.body.appendChild(songleWidgetElement)
