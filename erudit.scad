include <wordgame.scad>;

debug = false;
mode = "3d"; // [2d | 3d]
show_pads=true;
show_text=true;
full_board=true;

BOARD_SIZE = [15, 15];

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
    ["А", 1, 1], ["Э", 1, 10], ["\u2731", 1, undef], ["", 1, undef]
];

ERUDIT_CHARS = debug ? DEBUG_ERUDIT_CHARS_RU : ERUDIT_CHARS_RU;

if (mode == "3d") erudit();
else if (mode == "2d") projection(cut = false) erudit();

module erudit(chars)
{
    char_pads(
        chars=ERUDIT_CHARS,
        board_size=BOARD_SIZE,
        show_pads=show_pads,
        show_text=show_text,
        full_board=full_board);
}
