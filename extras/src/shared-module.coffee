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
###
__swExtra__.initializeAllModule =
  (module) ->
    __swExtra__.modules ?= []
    __swExtra__.modules.push(module)

    window.onSongleWidgetCreate =
      (apiKey, songleWidget) ->
        __swExtra__.initializeCreateModule(songleWidget)

    window.onSongleWidgetError =
      (apiKey, songleWidget) ->
        __swExtra__.initializeErrorModule(songleWidget)

    window.onSongleWidgetReady =
      (apiKey, songleWidget) ->
        __swExtra__.initializeReadyModule(songleWidget)

###
  @function
###
__swExtra__.initializeCreateModule =
  (songleWidget, options = {}) ->
    options.force ?= false

    for module in __swExtra__.modules
      if !module.__wasCreated__ || options.force
        module.onCreate &&
        module.onCreate(songleWidget)

      module.__wasCreated__ = true

###
  @function
###
__swExtra__.initializeErrorModule =
  (songleWidget, options = {}) ->
    options.force ?= false

    for module in __swExtra__.modules
      if !module.__wasErrored__ || options.force
        module.onError &&
        module.onError(songleWidget)

      module.__wasErrored__ = true

###
  @function
###
__swExtra__.initializeReadyModule =
  (songleWidget, options = {}) ->
    options.force ?= false

    for module in __swExtra__.modules
      if !module.__wasReadied__ || options.force
        module.onReady &&
        module.onReady(songleWidget)

      module.__wasReadied__ = true

###
  @function
###
__swExtra__.random =
  (min, max) ->
    min ?= 0x00000000
    max ?= 0x7fffffff

    return Math.floor(Math.random() * ((max - min) + 1) + min)
