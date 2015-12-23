#!/bin/bash

PWD=`pwd`
DEBUG="false"
SCAD="erudit.scad"
EXPORT_DIR="$PWD/export"

PADS_TEXT_2D_DXF="erudit_pads_text_2d.dxf"
PADS_2D_DXF="erudit_pads_2d.dxf"
BOARD_BACK_2D_DXF="erudit_board_back_2d.dxf"

mkdir -p $EXPORT_DIR

echo "Exporting to '$EXPORT_DIR'..."

echo "Exporting pads text to '$PADS_TEXT_2D_DXF'..."
openscad -o $EXPORT_DIR/$PADS_TEXT_2D_DXF --render -D 'mode="pads-text-2d"' -D "debug=$DEBUG" $SCAD

echo "Exporting pads to '$PADS_2D_DXF'..."
openscad -o $EXPORT_DIR/$PADS_2D_DXF --render -D 'mode="pads-2d"' -D "debug=$DEBUG" $SCAD

echo "Exporting board back to '$BOARD_BACK_2D_DXF'..."
openscad -o $EXPORT_DIR/$BOARD_BACK_2D_DXF --render -D 'mode="board-back-2d"' -D "debug=$DEBUG" $SCAD
