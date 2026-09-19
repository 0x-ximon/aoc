import java.io.File

fun main(): Unit {
    val file = File("input.txt")
    val data: List<String> = file.readLines()

    val firstAnswer = first(data)
    println("First Answer: $firstAnswer")

    val secondAnswer = second(data)
    println("Second Answer: $secondAnswer")
}
