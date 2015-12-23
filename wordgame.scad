include <MCAD/layouts.scad>;
include <MCAD/2Dshapes.scad>;
include <MCAD/materials.scad>;
include <MCAD/units.scad>;

$fn=50;

DEFAULT_TEXT_FONT = "Monospace:style=Bold";
DEFAULT_TEXT_COLOR = "Black";

DEFAULT_MATERIAL_DEPTH = 4*mm;

DEFAULT_BOARD_MATRIX_COLOR = "DimGray";
DEFAULT_BOARD_BACK_COLOR = "DarkGray";
DEFAULT_BOARD_PADDING = 10*mm;
DEFAULT_BOARD_DIM = [15, 15];
DEFAULT_BOARD_ROUNDING = [
    [1*mm, 1*mm],
    [1*mm, 1*mm],
    [1*mm, 1*mm],
    [1*mm, 1*mm]
];

DEFAULT_PAD_COLOR = "Tan";
DEFAULT_PAD_SIZE = [10*mm, 10*mm, DEFAULT_MATERIAL_DEPTH];
DEFAULT_PAD_MARGIN = 1*mm;
DEFAULT_PAD_ROUNDING = [
    [1*mm, 1*mm],
    [1*mm, 1*mm],
    [1*mm, 1*mm],
    [1*mm, 1*mm]
];

module gameboard(
    board_dim = DEFAULT_BOARD_DIM,
    board_padding = DEFAULT_BOARD_PADDING,
    board_rounding = DEFAULT_BOARD_ROUNDING,
    pad_size = DEFAULT_PAD_SIZE,
    pad_margin = DEFAULT_PAD_MARGIN,
    show_board_matrix = true,
    show_board_back = true)
{
    board_border = 2 * board_padding - pad_margin;
    board_width = (pad_size[0] + pad_margin) * board_dim[0] + board_border;
    board_height = (pad_size[1] + pad_margin) * board_dim[1] + board_border;
    board_depth = pad_size[2];

    // Board matrix.
    if (show_board_matrix)
    {
        board_matrix_size = [
            board_width,
            board_height,
            board_depth / 3
        ];

        translate([0, 0, show_board_back ? board_depth : 0])
        color(DEFAULT_BOARD_MATRIX_COLOR)
        linear_extrude(board_matrix_size[2])
        complexRoundSquare(
            board_matrix_size,
            rads1 = board_rounding[0],
            rads2 = board_rounding[1],
            rads3 = board_rounding[2],
            rads4 = board_rounding[3],
            center = false
        );
    }

    // Board back.
    if (show_board_back)
    {
        board_back_size = [
            board_width,
            board_height,
            board_depth
        ];

        color(DEFAULT_BOARD_BACK_COLOR)
        linear_extrude(board_back_size[2])
        complexRoundSquare(
            board_back_size,
            rads1 = board_rounding[0],
            rads2 = board_rounding[1],
            rads3 = board_rounding[2],
            rads4 = board_rounding[3],
            center = false
        );
    }
}

module pad(
    pad_size = DEFAULT_PAD_SIZE,
    pad_rounding = DEFAULT_PAD_ROUNDING)
{
    depth = pad_size[2];

    color(DEFAULT_PAD_COLOR)
    linear_extrude(depth)
    complexRoundSquare(
        pad_size,
        rads1=pad_rounding[0],
        rads2=pad_rounding[1],
        rads3=pad_rounding[2],
        rads4=pad_rounding[3],
        center=false
    );
}

module pad_text(
    char,
    value,
    pad_size = DEFAULT_PAD_SIZE,
    font = DEFAULT_TEXT_FONT)
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
        translate([char_x, max_char_size*0.5])
        text(
            char,
            size=char_text_size,
            font=font,
            valign="center",
            halign="center"
        );

        // Value.
        translate([width*0.93, max_char_size*0.1])
        text(
            value,
            size=value_text_size,
            font=font,
            valign="bottom",
            halign="right"
        );
    }
}

// chars: [char, count, value].
module wordgame(
    chars,
    board_dim = DEFAULT_BOARD_DIM,
    board_padding = DEFAULT_BOARD_PADDING,
    pad_size = DEFAULT_PAD_SIZE,
    pad_margin = DEFAULT_PAD_MARGIN,
    rounding = [DEFAULT_PAD_ROUNDING, DEFAULT_PAD_ROUNDING],
    font = DEFAULT_TEXT_FONT,
    show_text = true,
    show_pads = true,
    show_board_matrix = true,
    show_board_back = true,
    fill_board = true)
{
    columns = board_dim[0];
    rows = board_dim[1];
    width = pad_size[0];
    height = pad_size[1];
    depth = pad_size[2];
    step = width + pad_margin;

    full_chars = [
        for (c = chars)
            let (count = c[1])
                for (i = [0:count-1]) [c[0],c[2]] ];

    chars_count = len(full_chars);
    pads_count = fill_board ? columns*rows : chars_count;

    if (chars_count > pads_count)
        echo(str(
            "<span style=\"color: red;\">",
            "<b>WARNING: chars more than pads! ",
            "Not all chars will be rendered.</b>",
            "</span>"
        ));

    // Draw game board.
    if (show_board_matrix || show_board_back)
    {
        gameboard(
            board_dim=board_dim,
            board_padding=board_padding,
            pad_size=pad_size,
            pad_margin=pad_margin,
            show_board_matrix = show_board_matrix,
            show_board_back = show_board_back
        );
    }

    // Draw pads with text.
    if (show_pads || show_text)
    {
        translate([board_padding, board_padding, show_board_back ? depth : 0])
        {
            for (i = [0:pads_count - 1])
            {
                is_empty = i >= chars_count;

                x = i % columns;
                y = floor(i / columns);

                translate([x*step,y*step])
                {
                    if (show_pads)
                        pad(pad_size=pad_size, rounding=rounding);

                    if (show_text && !is_empty)
                    {
                        translate([0, 0, show_pads ? depth : 0])
                        {
                            c = full_chars[i];
                            char = c[0];
                            value = c[1] == undef ? "" : str(c[1]);
                            pad_text(
                                char = char,
                                value = value,
                                pad_size = pad_size,
                                font = font
                            );
                        }
                    }
                }
            }
        }
    }
}
