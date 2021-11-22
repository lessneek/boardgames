#!/bin/bash

PWD=`pwd`
DEBUG="false"
SCAD="erudit.scad"
EXPORT_DIR="$PWD/export"

PADS_TEXT_2D="erudit_pads_text_2d"
PADS_2D="erudit_pads_2d"
BOARD_BACK_2D="erudit_board_back_2d"

FORMAT="svg"

mkdir -p $EXPORT_DIR

echo "Exporting to '$EXPORT_DIR'..."

#echo "Exporting pads text to '$PADS_TEXT_2D.$FORMAT'..."
#openscad -o $EXPORT_DIR/$PADS_TEXT_2D.$FORMAT --render -D 'mode="pads-text-2d"' -D "debug=$DEBUG" $SCAD

echo "Exporting pads to '$PADS_2D.$FORMAT'..."
openscad -o $EXPORT_DIR/$PADS_2D.$FORMAT --render -D 'mode="pads-2d"' -D "debug=$DEBUG" $SCAD

#echo "Exporting board back to '$BOARD_BACK_2D.$FORMAT'..."
#openscad -o $EXPORT_DIR/$BOARD_BACK_2D.$FORMAT --render -D 'mode="board-back-2d"' -D "debug=$DEBUG" $SCAD
