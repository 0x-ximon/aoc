package ximon;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import java.util.List;

public class TestMain {
    private List<String> data =
            List.of(
                    "[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}",
                    "[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}",
                    "[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}");

    @Test
    public void testFirst() {
        int firstExpected = 7;
        int firstActual = Lib.first(data);
        assertEquals(firstExpected, firstActual);
    }

    @Test
    public void testSecond() {
        // int secondExpected = 0;
        // int secondActual = Lib.second(data);
        // assertEquals(secondExpected, secondActual);
    }
}
