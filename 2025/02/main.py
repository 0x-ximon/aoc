import math

from lib import first, second


def main():
    with open("input.txt", "r") as f:
        raw = f.read()
        data = raw.split(",")

        first_answer = first(data)
        print(f"First Answer: {first_answer}")

        second_answer = second(data)
        print(f"Second Answer: {second_answer}")


if __name__ == "__main__":
    main()
