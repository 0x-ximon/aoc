package ximon;

import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(String[] args) {
        try {
            var path = Path.of("input.txt");
            var data = Files.readAllLines(path);

            var firstAnswer = Lib.first(data);
            System.out.println("First Answer: %s".formatted(firstAnswer));

            var secondAnswer = Lib.second(data);
            System.out.println("Second Answer: %s".formatted(secondAnswer));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
