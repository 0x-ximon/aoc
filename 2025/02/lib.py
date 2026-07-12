import math
from typing import Sequence


def first(data: Sequence[str]) -> int:
    result = 0

    def next(x: int) -> int:
        s = str(x)
        n = len(s)

        if x <= 10:
            return 11

        if n % 2 == 1:
            m = (n + 1) / 2
            half = str(int(10 ** (m - 1)))
            r = int(half + half)
            return r

        m = int(n / 2)
        a = int(s[:m])
        b = int(s[m:])

        if a > b:
            next = str(a)
        else:
            next = str(a + 1)

        r = int(next + next)
        return r

    for line in data:
        bounds = line.split("-")
        assert len(bounds) == 2, f"Invalid range: {bounds}"

        p, q = int(bounds[0]), int(bounds[1])
        i = next(p - 1)

        while i <= q:
            result += i
            i = next(i)

    return result


def second(data: Sequence[str]) -> int:
    result = 0

    def next(x: int) -> int:
        if x <= 9:
            return 11

        def find(s: str) -> None:
            nonlocal m

            n = len(s)

            for i in range(n // 2, 0, -1):
                if n % i != 0:
                    continue

                # Get first section and how many times to repeat
                sub = int(s[:i])
                r = n // i

                # Not incrementing sub
                value = int(str(sub) * r)
                if value > x and value < m:
                    m = value

                # Incrementing sub
                sub += 1
                value = int(str(sub) * r)
                if value > x and value < m:
                    m = value

        m = math.inf
        s = str(x)

        find(s)
        find(str(10 ** len(s)))

        return int(m)

    for line in data:
        bounds = line.split("-")
        assert len(bounds) == 2, f"Invalid range: {bounds}"

        p, q = int(bounds[0]), int(bounds[1])
        i = next(p - 1)

        while i <= q:
            result += i
            i = next(i)

    return result
