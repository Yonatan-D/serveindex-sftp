#!/bin/bash
nohup node app.js --args=${SS_ARGS} &
entrypoint ${SS_ARGS}
