import math


def next(x: int) -> int:
    if x <= 9:
        return 11

    def find(s: str) -> None:
        nonlocal jump

        n = len(s)

        for i in range(n // 2, 0, -1):
            if n % i != 0:
                continue

            # Get first section and how many times to repeat
            sub = int(s[:i])
            r = n // i

            # Not incrementing sub
            value = int(str(sub) * r)
            if value > x and value < jump:
                jump = value

            # Incrementing sub
            sub += 1
            value = int(str(sub) * r)
            if value > x and value < jump:
                jump = value

    jump = math.inf
    s = str(x)

    find(s)
    find(str(10 ** len(s)))

    return int(jump)


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
