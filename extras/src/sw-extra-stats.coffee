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
__swExtra__.initializeAllModule
  onCreate:
    (songleWidget) ->
      setTimeout ->
        rootElement = document.createElement("div")
        rootElement.className = "sw-extra-stats"

        rootElement.style.position   = "fixed"
        rootElement.style.color      = "rgb(64, 64, 64)"
        rootElement.style.fontFamily = "'consolas', 'Courier New', 'Courier', 'Monaco', 'monospace'"
        rootElement.style.fontSize   = 11.5 + "px"
        rootElement.style.left       = 10   + "px"
        rootElement.style.bottom     = 10   + "px"

        rootElement.appendChild(
          createStatElement "playing-time", "Playing time",
            (rootElement) ->
              childElement = document.createElement("span")
              childElement.className = "position"
              childElement.textContent = "00:00"

              rootElement.appendChild(childElement)

              childElement = document.createElement("span")
              childElement.textContent = "/"

              rootElement.appendChild(childElement)

              childElement = document.createElement("span")
              childElement.className = "duration"
              childElement.textContent = "00:00"

              rootElement.appendChild(childElement)
        )

        rootElement.appendChild(
          createStatElement "beat", "Beat",
            (rootElement) ->
              rootElement.appendChild(document.createTextNode("-"))
        )

        rootElement.appendChild(
          createStatElement "chord", "Chord",
            (rootElement) ->
              rootElement.appendChild(document.createTextNode("-"))
        )

        rootElement.appendChild(
          createStatElement "note", "Note",
            (rootElement) ->
              rootElement.appendChild(document.createTextNode("-"))
        )

        rootElement.appendChild(
          createStatElement "chorus", "Chorus segment",
            (rootElement) ->
              rootElement.appendChild(document.createTextNode("-"))
        )

        rootElement.appendChild(
          createStatElement "repeat", "Repeat segment",
            (rootElement) ->
              rootElement.appendChild(document.createTextNode("-"))
        )

        document.body.appendChild(rootElement)
      , 0 # [ms]

      ###
        @function
        @private
      ###
      createStatElement =
        (className, statTitle, onCreate) ->
          rootElement = document.createElement("div")

          childElement = document.createElement("div")
          childElement.appendChild(document.createTextNode(statTitle))

          childElement.style.padding = "0px 4px"
          childElement.style.borderLeft = "2px solid #e17"

          rootElement.appendChild(childElement)

          childElement = document.createElement("div")
          childElement.className = className

          childElement.style.padding = "0px 4px"
          childElement.style.borderLeft = "0px solid #e17"

          rootElement.appendChild(childElement)

          onCreate &&
          onCreate(childElement)

          return rootElement
  onReady:
    (songleWidget) ->
      songleWidget.on "beatPlay",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .beat")

          switch(e.beat.position)
            when 1
              rootElement.textContent = "x - - - (bpm:" + Math.floor(e.beat.bpm) + ")"
            when 2
              rootElement.textContent = "- x - - (bpm:" + Math.floor(e.beat.bpm) + ")"
            when 3
              rootElement.textContent = "- - x - (bpm:" + Math.floor(e.beat.bpm) + ")"
            when 4
              rootElement.textContent = "- - - x (bpm:" + Math.floor(e.beat.bpm) + ")"

      songleWidget.on "chordEnter",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .chord")

          rootElement.textContent = e.chord.name

      songleWidget.on "noteEnter",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .note")

          rootElement.textContent = "#{ e.note.pitch } Hz"

      songleWidget.on "chorusSegmentEnter",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .chorus")

          rootElement.textContent = "o"

      songleWidget.on "chorusSegmentLeave",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .chorus")

          rootElement.textContent = "-"

      songleWidget.on "repeatSegmentEnter",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .repeat")

          rootElement.textContent = "o"

      songleWidget.on "repeatSegmentLeave",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .repeat")

          rootElement.textContent = "-"

      songleWidget.on "playingProgress",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .playing-time")

          childElementElement = rootElement.querySelector(".duration")
          childElementElement.textContent = createPlayingTimeText(songleWidget.duration)

      songleWidget.on "playingProgress",
        (e) ->
          rootElement = document.querySelector(".sw-extra-stats .playing-time")

          childElementElement = rootElement.querySelector(".position")
          childElementElement.textContent = createPlayingTimeText(songleWidget.position)

      ###
        @function
        @private
      ###
      createPlayingTimeText =
        (songleWidgetPlayingTime) ->
          minutes = "00" + Math.floor(songleWidgetPlayingTime.minutes) % 60
          seconds = "00" + Math.floor(songleWidgetPlayingTime.seconds) % 60

          return minutes.substr(minutes.length - 2) + ":" + seconds.substr(seconds.length - 2)
