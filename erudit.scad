use <wordgame.scad>;

// Modes.
MODE_FULL_3D = "full-3d";
MODE_PADS_TEXT_2D = "pads-text-2d";
MODE_PADS_2D = "pads-2d";
MODE_BOARD_BACK_2D = "board-back-2d";
DEFAULT_MODE = MODE_FULL_3D;

// Command line variables.
debug = false;
mode = DEFAULT_MODE;

// [char, count, value].
ERUDIT_CHARS_RU = [
    ["А", 10, 1], ["Б", 3, 3], ["В", 5, 2], ["Г", 3, 3], ["Д", 5, 2],
    ["Е", 9, 1], ["Ж", 2, 5], ["З", 2, 5], ["И", 8, 1], ["Й", 4, 2],
    ["К", 6, 2], ["Л", 4, 2], ["М", 5, 2], ["Н", 8, 1], ["О", 10, 1],
    ["П", 6, 2], ["Р", 6, 2], ["С", 6, 2], ["Т", 5, 2], ["У", 3, 3],
    ["Ф", 1, 10], ["Х", 2, 5], ["Ц", 1, 10], ["Ч", 2, 5], ["Ш", 1, 10],
    ["Щ", 1, 10], ["Ъ", 1, 10], ["Ы", 2, 5], ["Ь", 2, 5], ["Э", 1, 10],
    ["Ю", 1, 10], ["Я", 3, 3], ["\u2731", 3, undef], ["", 4, undef]
];

// [char, count, value].
DEBUG_ERUDIT_CHARS_RU = [
    ["А", 1, 1], ["Э", 1, 10], ["\u2731", 3, undef], ["", 1, undef]
];

DEFAULT_ERUDIT_BOARD_DIM = debug ? [3, 3] : [15, 15];
DEFAULT_ERUDIT_CHARS = debug ? DEBUG_ERUDIT_CHARS_RU : ERUDIT_CHARS_RU;

module withmode(mode)
{
    $show_text = false;
    $show_pads = false;
    $show_board_matrix = false;
    $show_board_back = false;
    $fill_board = false;

    if (mode == MODE_FULL_3D)
    {
        $show_pads = true;
        $show_text = true;
        $show_board_matrix = true;
        $show_board_back = true;
        $fill_board = true;
        children();
    }
    else if (mode == MODE_PADS_TEXT_2D)
    {
        $show_text = true;
        projection(cut = false) children();
    }
    else if (mode == MODE_PADS_2D)
    {
        $show_pads = true;
        $fill_board = true;
        projection(cut = false) children();
    }
    else if (mode == MODE_BOARD_BACK_2D)
    {
        $show_board_back = true;
        projection(cut = false) children();
    }
}

module erudit(
    chars = DEFAULT_ERUDIT_CHARS,
    board_dim = DEFAULT_ERUDIT_BOARD_DIM,
    mode = DEFAULT_MODE)
{
    withmode(mode) wordgame(
        chars = chars,
        board_dim = board_dim,
        show_pads = $show_pads,
        show_text = $show_text,
        show_board_matrix = $show_board_matrix,
        show_board_back = $show_board_back,
        fill_board = $fill_board
    );
}

erudit(mode = mode);
