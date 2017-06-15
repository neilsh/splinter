#!/bin/bash

# Copyright 2016 splinter authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set -ev

if [ "${DRIVER}" = "tests/test_djangoclient.py" ]; then
  pip install -q Django==${DJANGO_VERSION}
fi

# NOTE: wasn't able to get working with versions > v0.14
# Probably related to: "Note that geckodriver v0.16.0 is only compatible with Selenium 3.4 and greater."
# https://github.com/mozilla/geckodriver/releases

wget https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-linux64.tar.gz
mkdir geckodriver
tar -xzf geckodriver-v0.14.0-linux64.tar.gz -C geckodriver
mkdir $HOME/bin
mv ./geckodriver/geckodriver $HOME/bin/geckodriver
chmod +x $HOME/bin/geckodriver

# zip file contains a single file: 'chromedriver' (executable)
#FILE=`mktemp`; wget "http://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip" -qO $FILE && unzip $FILE chromedriver -d ~; mv $HOME/chromedriver/chromedriver $HOME/bin/chromedriver; rm $FILE; chmod +x $HOME/bin/chromedriver;
wget "http://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip" -qO ctemp.zip && unzip ctemp.zip chromedriver -d ~
mv $HOME/chromedriver $HOME/bin/chromedriver
chmod +x $HOME/bin/chromedriver;

export PATH=$HOME/bin:$PATH

ls -l $HOME/bin

# confirm chromedriver and geckodriver on PATH
which chromedriver
which geckodriver

# start selenium-server after the webdrivers
wget https://selenium-release.storage.googleapis.com/3.4/selenium-server-standalone-3.4.0.jar -O selenium-server.jar
java -jar selenium-server.jar > /dev/null 2>&1 &

