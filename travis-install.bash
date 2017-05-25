#!/bin/bash

# Copyright 2016 splinter authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set -ev

if [ "${DRIVER}" = "tests/test_djangoclient.py" ]; then
  pip install -q Django==${DJANGO_VERSION}
fi

#if [ "${DRIVER}" = "tests/test_webdriver_remote.py" ]; then
  sleep 1

	wget http://goo.gl/PJUZfa -O selenium-server.jar
	java -jar selenium-server.jar > /dev/null 2>&1 &
	sleep 1
#fi

#if [ "${DRIVER}" = "tests/test_webdriver_firefox.py" ]; then

    wget https://github.com/mozilla/geckodriver/releases/download/v0.14.0/geckodriver-v0.14.0-linux64.tar.gz
    mkdir geckodriver
    tar -xzf geckodriver-v0.14.0-linux64.tar.gz -C geckodriver
    mkdir $HOME/bin
    mv ./geckodriver/geckodriver $HOME/bin/geckodriver
    chmod +x $HOME/bin/geckodriver

#fi

#if [ "${DRIVER}" = "tests/test_webdriver_chrome.py" ]; then
    sleep 1

    FILE=`mktemp`; wget "http://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip" -qO $FILE && unzip $FILE chromedriver -d ~; mv chromedriver $HOME/bin/chromedriver; rm $FILE; chmod +x $HOME/bin/chromedriver;
#fi
export PATH=$HOME:$HOME/bin:$PATH

ls -l $HOME/bin
print -rl -- $commands