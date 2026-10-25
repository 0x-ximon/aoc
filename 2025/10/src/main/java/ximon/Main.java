package ximon;

import java.nio.file.Files;
import java.nio.file.Path;

public class Main {
    public static void main(final String[] args) {
        try {
            final var path = Path.of("input.txt");
            final var data = Files.readAllLines(path);

            final var firstAnswer = Lib.first(data);
            System.out.println("First Answer: %s".formatted(firstAnswer));

            final var secondAnswer = Lib.second(data);
            System.out.println("Second Answer: %s".formatted(secondAnswer));
        } catch (final Exception e) {
            e.printStackTrace();
        }
    }
}
