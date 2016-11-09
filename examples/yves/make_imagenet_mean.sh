#!/usr/bin/env sh
# Compute the mean image from the imagenet training lmdb
# N.B. this is available in data/ilsvrc12

EXAMPLE=../../examples/yves
DATA=../../data/yves
TOOLS=../../build/tools


$TOOLS/compute_image_mean $EXAMPLE/yves_train_lmdb $EXAMPLE/yves_mean.binaryproto

echo "Done."
