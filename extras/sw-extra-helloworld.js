/**
 * @author Takahiro INOUE <takahiro.inoue@aist.go.jp>
 * @license Songle Widget API Examples
 *
 * Visit http://songle.jp/info/Credit.html OR http://widget.songle.jp/docs/v1 for documentation.
 * Copyright (c) 2015 National Institute of Advanced Industrial Science and Technology (AIST)
 *
 * Distributed under the terms of the MIT license only for non-commercial purposes.
 * http://www.opensource.org/licenses/mit-license.html
 *
 * This notice shall be included in all copies or substantial portions of this Songle Widget API Examples.
 * If you are interested in commercial use of Songle Widget API, please contact "songle-ml@aist.go.jp".
 */
(function(){if(window.__swExtra__==null){window.__swExtra__={}}__swExtra__.initializeAllModule=function(a){if(__swExtra__.modules==null){__swExtra__.modules=[]}__swExtra__.modules.push(a);window.onSongleWidgetCreate=function(c,b){return __swExtra__.initializeCreateModule(b)};window.onSongleWidgetError=function(c,b){return __swExtra__.initializeErrorModule(b)};return window.onSongleWidgetReady=function(c,b){return __swExtra__.initializeReadyModule(b)}};__swExtra__.initializeCreateModule=function(b,c){var f,a,e,g,d;if(c==null){c={}}if(c.force==null){c.force=false}g=__swExtra__.modules;d=[];for(f=0,a=g.length;f<a;f++){e=g[f];if(!e.__wasCreated__||c.force){e.onCreate&&e.onCreate(b)}d.push(e.__wasCreated__=true)}return d};__swExtra__.initializeErrorModule=function(b,c){var f,a,e,g,d;if(c==null){c={}}if(c.force==null){c.force=false}g=__swExtra__.modules;d=[];for(f=0,a=g.length;f<a;f++){e=g[f];if(!e.__wasErrored__||c.force){e.onError&&e.onError(b)}d.push(e.__wasErrored__=true)}return d};__swExtra__.initializeReadyModule=function(b,c){var f,a,e,g,d;if(c==null){c={}}if(c.force==null){c.force=false}g=__swExtra__.modules;d=[];for(f=0,a=g.length;f<a;f++){e=g[f];if(!e.__wasReadied__||c.force){e.onReady&&e.onReady(b)}d.push(e.__wasReadied__=true)}return d};__swExtra__.random=function(b,a){if(b==null){b=0}if(a==null){a=2147483647}return Math.floor(Math.random()*((a-b)+1)+b)}}).call(this);(function(){__swExtra__.initializeAllModule({onReady:function(a){return alert("Hello,Songle Widget!!")}})}).call(this);