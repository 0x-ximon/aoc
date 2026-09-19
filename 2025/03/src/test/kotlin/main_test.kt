import kotlin.test.Test
import kotlin.test.assertEquals

class TestMain {
    val data: List<String> =
        listOf(
            "987654321111111",
            "811111111111119",
            "234234234234278",
            "818181911112111",
        )

    @Test
    fun testFirst() {
        val firstExpected: Long = 357
        val firstActual = first(data)
        assertEquals(firstExpected, firstActual)
    }

    @Test
    fun testSecond() {
        val secondExpected = 3121910778619
        val secondActual: Long = second(data)
        assertEquals(secondExpected, secondActual)
    }
}
