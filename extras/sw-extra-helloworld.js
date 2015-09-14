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
(function(){if(window.__swExtra__==null){window.__swExtra__={}}__swExtra__.initializeAllModule=function(a){if(__swExtra__.modules==null){__swExtra__.modules=[]}__swExtra__.modules.push(a);window.onSongleWidgetCreate=function(c,b){return __swExtra__.initializeCreateModule(b)};window.onSongleWidgetError=function(c,b){return __swExtra__.initializeErrorModule(b)};return window.onSongleWidgetReady=function(c,b){return __swExtra__.initializeReadyModule(b)}};__swExtra__.initializeCreateModule=function(c,d){var e,g,b,f,a;if(d==null){d={}}if(d.force==null){d.force=false}f=__swExtra__.modules;a=[];for(g=0,b=f.length;g<b;g++){e=f[g];if(!e.__wasCreated__||d.force){e.onCreate&&e.onCreate(c)}a.push(e.__wasCreated__=true)}return a};__swExtra__.initializeErrorModule=function(c,d){var e,g,b,f,a;if(d==null){d={}}if(d.force==null){d.force=false}f=__swExtra__.modules;a=[];for(g=0,b=f.length;g<b;g++){e=f[g];if(!e.__wasErrored__||d.force){e.onError&&e.onError(c)}a.push(e.__wasErrored__=true)}return a};__swExtra__.initializeReadyModule=function(c,d){var e,g,b,f,a;if(d==null){d={}}if(d.force==null){d.force=false}f=__swExtra__.modules;a=[];for(g=0,b=f.length;g<b;g++){e=f[g];if(!e.__wasReadied__||d.force){e.onReady&&e.onReady(c)}a.push(e.__wasReadied__=true)}return a};__swExtra__.random=function(b,a){if(b==null){b=0}if(a==null){a=2147483647}return Math.floor(Math.random()*((a-b)+1)+b)}}).call(this);(function(){__swExtra__.initializeAllModule({onReady:function(a){return alert("Hello,Songle Widget!!")}})}).call(this);