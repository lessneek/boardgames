include <wordgame.scad>;

debug = false;
type = "full";

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

if (type == "full") erudit(ERUDIT_CHARS);
else if (type == "pads") erudit_pads_projection(ERUDIT_CHARS);
else if (type == "text") erudit_pads_text_projection(ERUDIT_CHARS);

module erudit(chars)
{
    char_pads(chars=chars);
}

module erudit_pads_projection(chars)
{
    projection(cut = false)
        char_pads(chars=chars, show_text=false);
}

module erudit_pads_text_projection(chars)
{
    projection(cut = false)
        char_pads(chars=chars, show_pad=false);
}
