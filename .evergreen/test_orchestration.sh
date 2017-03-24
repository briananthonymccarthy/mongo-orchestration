#!/bin/bash
set -o errexit  # Exit the script on error and fail
#set -o pipefail

MONGOBIN=${MONGOBIN}

echo "MONGOBIN IS: $MONGOBIN"
if [ -f venv/bin/activate ]; then
  . venv/bin/activate
elif [ -f venv/Scripts/activate ]; then
  . venv/Scripts/activate
elif virtualenv --system-site-packages venv || python -m virtualenv --system-site-packages venv; then
  if [ -f venv/bin/activate ]; then
    . venv/bin/activate
  elif [ -f venv/Scripts/activate ]; then
    . venv/Scripts/activate
  fi
 pip install pbr unittest2
fi

# Run tests
# This is a single test module that passes on linux and windows with all versions of mongodb.
python setup.py test -s tests.test_container

# These take about 30 - 40 minutes and generate a lot of debug info in the logs. 
# There is are only a couple of test failures.
#python setup.py test -s tests.test_replica_sets

# This runs the entire test suite.
#python setup.py test
