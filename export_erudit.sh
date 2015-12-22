#!/bin/bash

PWD=`pwd`
DEBUG="false"
SCAD="erudit.scad"
EXPORT_DIR="$PWD/export"
PADS_DXF="$EXPORT_DIR/erudit_pads.dxf"
PADS_TEXT_DXF="$EXPORT_DIR/erudit_pads_text.dxf"

mkdir -p $EXPORT_DIR

echo "Exporting pads to '$PADS_DXF'..."
openscad -o $PADS_DXF --render -D 'type="pads"' -D "debug=$DEBUG" $SCAD

echo "Exporting pads text to '$PADS_TEXT_DXF'..."
openscad -o $PADS_TEXT_DXF --render -D 'type="text"' -D "debug=$DEBUG" $SCAD
