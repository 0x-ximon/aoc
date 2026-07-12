from lib import first, second


def test_main():
    raw = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
    data = raw.split(",")

    first_expected = 1227775554
    first_result = first(data)
    assert first_expected == first_result

    second_expected = 4174379265
    second_result = second(data)
    assert second_expected == second_result
