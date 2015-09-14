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
  onReady:
    (songleWidget) ->
      if !window.createjs
        progress = 0

        # Require thread party library. Please see "https://code.createjs.com/easeljs".
        easelElement = document.createElement("script")
        easelElement.async = false
        easelElement.defer = false
        easelElement.src   = "https://code.createjs.com/easeljs-0.8.1.min.js"
        easelElement.type  = "text/javascript"

        easelElement.addEventListener "load",
          ->
            ++ progress

            if progress >= 2
              readySongleWidget(songleWidget)
        , false

        document.body.appendChild(easelElement)

        # Require thread party library. Please see "https://code.createjs.com/tweenjs".
        tweenElement = document.createElement("script")
        tweenElement.async = false
        tweenElement.defer = false
        tweenElement.src   = "https://code.createjs.com/tweenjs-0.6.1.min.js"
        tweenElement.type  = "text/javascript"

        tweenElement.addEventListener "load",
          ->
            ++ progress

            if progress >= 2
              readySongleWidget(songleWidget)
        , false

        document.body.appendChild(tweenElement)
      else
        readySongleWidget(songleWidget)

###
  @function
  @private
###
readySongleWidget =
  (songleWidget) ->
    setTimeout ->
      # ---- Intiailize EaselJs and TweenJs.
      stageElement = document.querySelector(".sw-extra-visualizer")

      if !stageElement
        stageElement = document.createElement("canvas")
        stageElement.className = "sw-extra-visualizer"
        stageElement.width  = getScreenSizeW()
        stageElement.height = getScreenSizeH()

        stageElement.style.position = "fixed"
        stageElement.style.left   = 0 + "px"
        stageElement.style.top    = 0 + "px"
        stageElement.style.zIndex = -1

        document.body.appendChild(stageElement)

      addEventListener "scroll",
        ->
          stageElement.width  = getScreenSizeW()
          stageElement.height = getScreenSizeH()
        , false

      addEventListener "resize",
        ->
          stageElement.width  = getScreenSizeW()
          stageElement.height = getScreenSizeH()
        , false

      stage = new createjs.Stage(stageElement)

      createjs.Ticker.addEventListener "tick",
        (e) ->
          stage.update(e)

      createjs.Ticker.setFPS(60)
      # ----

      # ---- If you comment out, you can disable visualizer for beat.
      songleWidget.on "beatPlay",
        (e) ->
          if e.beat.position == 1
            switch __swExtra__.random(MIN_TRAP_ID, MAX_TRAP_ID)
              when 1
                invokeTriangleTrap(stage)
              when 2
                invokeSquareTrap(stage)
              when 3
                invoke5StarTrap(stage)
              when 4
                invoke7StarTrap(stage)
              when 5
                invokeCircleTrap(stage)
      # ----

      # ---- If you comment out, you can disable visualizer for chord.
      songleWidget.on "chordPlay",
        (e) ->
          prevChord = e.chord.prev
          nextChord = e.chord

          if prevChord
            matchedChordName = prevChord.name.match(/^([A-G#]{1,2})/) || []
            prevChordName = matchedChordName[ 1 ] || "N"
          else
            prevChordName = "N"

          prevChordColor = SONGLE_CHORD_COLOR_LIST[ prevChordName ]

          if nextChord
            matchedChordName = nextChord.name.match(/^([A-G#]{1,2})/) || []
            nextChordName = matchedChordName[ 1 ] || "N"
          else
            nextChordName = "N"

          nextChordColor = SONGLE_CHORD_COLOR_LIST[ nextChordName ]

          createjs.Tween.get(prevChordColor)
            .to(nextChordColor, 250)
              .addEventListener "change",
                (e) ->
                  backgroundColor = e.target.target
                  backgroundColor.r = Math.floor(backgroundColor.r)
                  backgroundColor.g = Math.floor(backgroundColor.g)
                  backgroundColor.b = Math.floor(backgroundColor.b)

                  stageElement.style.backgroundColor =
                    "rgb(" +
                      backgroundColor.r + "," +
                      backgroundColor.g + "," +
                      backgroundColor.b +
                    ")"
      # ----

      # ---- If you comment out, you can disable visualizer for chorus.
      songleWidget.on "chorusSegmentEnter",
        (e) ->
          invokeWaveTrap stage,
            color: SONGLE_CHORUS_SEGMENT_COLOR
            direction: "L"
      # ----

      # ---- If you comment out, you can disable visualizer for repeat.
      songleWidget.on "repeatSegmentEnter",
        (e) ->
          invokeWaveTrap stage,
            color: SONGLE_REPEAT_SEGMENT_COLOR
            direction: "R"
      # ----

      songleWidget.on "play",
        ->
          resetState(stage)

      songleWidget.on "seek",
        ->
          resetState(stage)

      songleWidget.on "finish",
        ->
          resetState(stage)
    , 0 # [ms]

    ###
      @constant
      @private
    ###
    MIN_TRAP_ID = 1

    ###
      @constant
      @private
    ###
    MAX_TRAP_ID = 5

    ###
      @constant
      @private
    ###
    SONGLE_THEME_COLOR = "#e17"

    ###
      @constant
      @private
    ###
    SONGLE_CHORD_COLOR_LIST =
      "A":
        r: 0xcc
        g: 0xcc
        b: 0xee
      "A#":
        r: 0xcc
        g: 0xcc
        b: 0xff
      "B":
        r: 0xcc
        g: 0xee
        b: 0xcc
      "C":
        r: 0xcc
        g: 0xee
        b: 0xee
      "C#":
        r: 0xcc
        g: 0xff
        b: 0xff
      "D":
        r: 0xee
        g: 0xcc
        b: 0xcc
      "D#":
        r: 0xff
        g: 0xcc
        b: 0xcc
      "E":
        r: 0xee
        g: 0xcc
        b: 0xee
      "F":
        r: 0xee
        g: 0xee
        b: 0xcc
      "F#":
        r: 0xff
        g: 0xff
        b: 0xcc
      "G":
        r: 0xee
        g: 0xee
        b: 0xee
      "G#":
        r: 0xff
        g: 0xff
        b: 0xff
      "N":
        r: 0xff
        g: 0xff
        b: 0xff

    ###
      @constant
      @private
    ###
    SONGLE_CHORUS_SEGMENT_COLOR = "#f84"

    ###
      @constant
      @private
    ###
    SONGLE_REPEAT_SEGMENT_COLOR = "#48f"

    ###
      @function
      @private
    ###
    getScreenSizeW =
      ->
        return window.innerWidth

    ###
      @function
      @private
    ###
    getScreenSizeH =
      ->
        return window.innerHeight

    ###
      @function
      @private
    ###
    invokeGeometryTrap =
      (stage, options = {}) ->
        options.r           ?= 0
        options.vertexCount ?= 0

        geometry = new createjs.Shape
        geometry.graphics.beginStroke(SONGLE_THEME_COLOR).drawPolyStar(0, 0, 20, options.vertexCount, options.r, __swExtra__.random(0, 360))

        geometry.x = __swExtra__.random(0, getScreenSizeW())
        geometry.y = __swExtra__.random(0, getScreenSizeH())

        createjs.Tween.get(geometry)
          .to
            alpha:   0
            scaleX: 20
            scaleY: 20
          , 2000

        stage.addChild(geometry)

    ###
      @function
      @private
    ###
    invokeTriangleTrap =
      (stage) ->
        invokeGeometryTrap stage,
          vertexCount: 3

    ###
      @function
      @private
    ###
    invokeSquareTrap =
      (stage) ->
        invokeGeometryTrap stage,
          vertexCount: 4

    ###
      @function
      @private
    ###
    invoke5StarTrap =
      (stage) ->
        invokeGeometryTrap stage,
          r: 0.20
          vertexCount: 5

    ###
      @function
      @private
    ###
    invoke7StarTrap =
      (stage) ->
        invokeGeometryTrap stage,
          r: 0.20
          vertexCount: 7

    ###
      @function
      @private
    ###
    invokeCircleTrap =
      (stage) ->
        invokeGeometryTrap stage,
          vertexCount: 100

    ###
      @function
      @private
    ###
    invokeWaveTrap =
      (stage, options = {}) ->
        options.color     ?= SONGLE_THEME_COLOR
        options.direction ?= "L"

        for index in [0...10]
          ((index) ->
            circle = new createjs.Shape
            circle.graphics.beginStroke(options.color).drawCircle(0, 0, 20)

            switch options.direction
              when "L"
                circle.x = getScreenSizeW() / 10 *       index
                circle.y = getScreenSizeH() / 2
              when "R"
                circle.x = getScreenSizeW() / 10 * (10 - index)
                circle.y = getScreenSizeH() / 2

            setTimeout ->
              createjs.Tween.get(circle)
                .to
                  alpha:   0
                  scaleX: 20
                  scaleY: 20
                , 2000

              stage.addChild(circle)
            , 200 * index # [ms]
          )(index)

    ###
      @function
      @private
    ###
    resetState =
      (stage) ->
        stage.removeAllChildren()
