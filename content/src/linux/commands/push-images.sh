#!/bin/bash

echo Push images...

$(dirname $0)/push-image.sh conf $1 \
&& $(dirname $0)/push-image.sh extensions $1 \
&& $(dirname $0)/push-image.sh data $1