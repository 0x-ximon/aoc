fun first(data: List<String>): Long {
    var result: Long = 0

    for (line in data.iterator()) {
        var m = 0
        var n = line.length - 1

        for (i in 0..n) {
            for (j in i + 1..n) {
                val digits = line[i].toString() + line[j].toString()
                val k = digits.toInt()
                if (k > m) m = k
            }
        }

        result += m
    }

    return result
}

fun second(data: List<String>): Long {
    var result: Long = 0

    for (line in data.iterator()) {
        var p = 0
        var q = line.length - 11

        var digits = ""

        while (q <= line.length) {
            val window = line.slice(p..<q)
            var step = 1

            var m: Long = -1
            var n = window.length - 1

            for (i in 0..n) {
                val k = window[i].toString().toLong()
                if (k > m) {
                    step = i + 1
                    m = k
                }
            }

            p += step
            digits += m.toString()
            q += 1
        }

        result += digits.toLong()
    }

    return result
}
