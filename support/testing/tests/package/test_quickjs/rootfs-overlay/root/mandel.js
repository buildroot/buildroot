function mandel(file) {
    points = ",.:-;!/>)|&IH%*Z";
    for (y = -15; y <= 15; y++) {
        for (x = 1; x <= 84; x++) {
            i = 0;
            r = 0;
            for (k = 0; k <= 111; k++) {
                j = (r*r) - (i*i) - 2 + (x/25);
                i = 2 * r * i + (y/10);
                if ((j*j + i*i) >= 11) {
                    break;
                }
                r = j;
            }
            file.puts(points[k & 0xF]);
        }
        file.puts("\n");
    }
}

mandel(std.out);
