include <MCAD/layouts.scad>;
include <MCAD/2Dshapes.scad>;
include <MCAD/materials.scad>;
include <MCAD/units.scad>;

$fn=50;

DEFAULT_FONT = "Monospace:style=Bold";
DEFAULT_TEXT_COLOR = "Black";
DEFAULT_PAD_COLOR = "Tan";
DEFAULT_PAD_SIZE = [10*mm, 10*mm, 4*mm];
DEFAULT_PAD_ROUNDING = 1*mm;
DEFAULT_PAD_MARGIN = 1*mm;
DEFAULT_ROW_LIMIT = 15;

module pad(
    pad_size = DEFAULT_PAD_SIZE,
    rounding=[DEFAULT_PAD_ROUNDING, DEFAULT_PAD_ROUNDING])
{
    depth = pad_size[2];

    color(DEFAULT_PAD_COLOR) linear_extrude(depth) complexRoundSquare(
        pad_size,
        rads1=rounding,
        rads2=rounding,
        rads3=rounding,
        rads4=rounding,
        center=false
    );
}

module pad_text(
    char,
    value,
    pad_size = DEFAULT_PAD_SIZE,
    font=DEFAULT_FONT)
{
    width = pad_size[0];
    height = pad_size[1];
    max_char_size = min(width, height);
    char_text_size = max_char_size * 0.5;
    value_text_size = char_text_size * 0.5;
    value_len = len(value);
    char_x = width * (value_len == 0 ? 0.5 : value_len == 1 ? 0.4 : 0.3);

    color(DEFAULT_TEXT_COLOR)
    linear_extrude(0.1)
    {
        translate([char_x, max_char_size*0.5]) text(
            char,
            size=char_text_size,
            font=font,
            valign="center",
            halign="center"
        );

        // Value.
        translate([width*0.93, max_char_size*0.1]) text(
            value,
            size=value_text_size,
            font=font,
            valign="bottom",
            halign="right"
        );
    }
}

// chars: [char, count, value].
module char_pads(
    chars,
    row_limit=DEFAULT_ROW_LIMIT,
    pad_size=DEFAULT_PAD_SIZE,
    pad_margin=DEFAULT_PAD_MARGIN,
    rounding=[DEFAULT_PAD_ROUNDING, DEFAULT_PAD_ROUNDING],
    font=DEFAULT_FONT,
    show_text=true,
    show_pad=true)
{
    width = pad_size[0];
    height = pad_size[1];
    depth = pad_size[2];
    step = width + pad_margin;

    full_chars = [
        for (c = chars) let (count = c[1]) for (i = [0:count-1]) [c[0],c[2]] ];

    for (i = [0:len(full_chars)-1])
    {
        c = full_chars[i];
        char = c[0];
        value = c[1] == undef ? "" : str(c[1]);

        x = i % row_limit;
        y = floor(i / row_limit);

        translate([x*step,y*step])
        {
            if (show_pad)
                pad(pad_size=pad_size, rounding=rounding);

            if (show_text) translate([0, 0, show_pad ? depth : 0])
                pad_text(char=char, value=value, pad_size=pad_size, font=font);
        }
    }
}