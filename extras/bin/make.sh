#!/bin/bash
coffee -c -p ./src/shared-module.coffee > shared-module1.tmp.js
coffee -c -p ./src/sw-extra-chorus-player.coffee > sw-extra-chorus-player1.tmp.js
coffee -c -p ./src/sw-extra-helloworld.coffee > sw-extra-helloworld1.tmp.js
coffee -c -p ./src/sw-extra-stats.coffee > sw-extra-stats1.tmp.js
coffee -c -p ./src/sw-extra-visualizer.coffee > sw-extra-visualizer1.tmp.js
cat shared-module1.tmp.js sw-extra-chorus-player1.tmp.js > sw-extra-chorus-player2.tmp.js
cat shared-module1.tmp.js sw-extra-helloworld1.tmp.js > sw-extra-helloworld2.tmp.js
cat shared-module1.tmp.js sw-extra-stats1.tmp.js > sw-extra-stats2.tmp.js
cat shared-module1.tmp.js sw-extra-visualizer1.tmp.js > sw-extra-visualizer2.tmp.js
yuicompressor sw-extra-chorus-player2.tmp.js > sw-extra-chorus-player3.tmp.js
yuicompressor sw-extra-helloworld2.tmp.js > sw-extra-helloworld3.tmp.js
yuicompressor sw-extra-stats2.tmp.js > sw-extra-stats3.tmp.js
yuicompressor sw-extra-visualizer2.tmp.js > sw-extra-visualizer3.tmp.js
cat ./bin/LICENSE sw-extra-chorus-player3.tmp.js > sw-extra-chorus-player.js
cat ./bin/LICENSE sw-extra-helloworld3.tmp.js > sw-extra-helloworld.js
cat ./bin/LICENSE sw-extra-stats3.tmp.js > sw-extra-stats.js
cat ./bin/LICENSE sw-extra-visualizer3.tmp.js > sw-extra-visualizer.js
rm *.tmp.js
