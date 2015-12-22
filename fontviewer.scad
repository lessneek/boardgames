font_viewer();

module font_viewer(font_size=4)
{
    CHARS_EN = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    CHARS_RU = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";
    CHARS_SYM = "\u2600\u2622\u2626\u2684\u263C\u2731⚹";

    fonts = [
        "DejaVu Serif:style=Bold",
        "Arial:style=Bold",
        "Ubuntu Mono:style=Bold",
        "Monospace:style=Bold",
        "DejaVu Sans Mono:style=Bold"
    ];

    translate([30,30])
    for (i = [0:len(fonts)-1])
    {
        f = fonts[i];
        y = i * font_size*10;
        lines = [f, CHARS_EN, CHARS_RU, CHARS_SYM];
        lines_count = len(lines);
        for (l = [0:lines_count-1])
        {
            step = font_size*l*2;
            color(l == lines_count-1 ? "gold" : "white")
            translate([0,y+step])
            text(lines[lines_count-l-1], size=font_size, font=f);
        }
    }
}
