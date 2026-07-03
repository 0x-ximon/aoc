def next(x: int) -> int:
    s = str(x)
    n = len(s)

    if x <= 10:
        return 11

    if n % 2 == 1:
        m = (n + 1) / 2
        half = str(int(10 ** (m - 1)))
        result = int(half + half)
        return result

    m = int(n / 2)
    a = int(s[:m])
    b = int(s[m:])

    if a > b:
        next = str(a)
    else:
        next = str(a + 1)

    result = int(next + next)
    return result


def process(data: str) -> int:
    ranges = data.split(",")
    answer = 0

    for r in ranges:
        bounds = r.split("-")
        assert len(bounds) == 2, f"Invalid range: {bounds}"

        p, q = int(bounds[0]), int(bounds[1])
        i = next(p - 1)

        while i <= q:
            answer += i
            i = next(i)

    return answer


def main():
    with open("input.txt", "r") as f:
        data = f.read()
        answer = process(data)
        print(f"Answer: {answer}")


if __name__ == "__main__":
    main()
