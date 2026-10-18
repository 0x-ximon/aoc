package ximon;

import java.util.ArrayList;
import java.util.BitSet;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Set;

public class Lib {
    public static int first(List<String> data) {
        var result = 0;

        for (var line : data) {
            var k = 0;
            var p = 0;
            var q = 0;

            var target = new BitSet(); // Square Brackets
            while (q < line.length()) {
                var token = line.charAt(q);
                if (token == '[') p = q;
                if (token == ']') break;

                if (token == '.') {
                    target.clear(k);
                    k++;
                }

                if (token == '#') {
                    target.set(k);
                    k++;
                }

                q++;
            }

            var buttons = new ArrayList<ArrayList<Integer>>(); // Round Brackets
            while (q < line.length()) {
                var token = line.charAt(q);
                if (token == '{') break;

                if (token == '(') p = q;
                if (token == ')') {
                    var button = new ArrayList<Integer>();
                    var ss = line.substring(p + 1, q).split(",");
                    for (var s : ss) button.add(Integer.parseInt(s));
                    buttons.add(button);
                }

                q++;
            }

            var joltage = new ArrayList<Integer>(); // Curly Brackets
            while (q < line.length()) {
                var token = line.charAt(q);
                if (token == '{') p = q;
                if (token == '}') {
                    var ss = line.substring(p + 1, q).split(",");
                    for (var s : ss) joltage.add(Integer.parseInt(s));
                    break;
                }

                q++;
            }

            // Breadth-first Search
            record Level(BitSet current, Integer turns) {}
            Queue<Level> queue = new LinkedList<Level>();
            Set<BitSet> visited = new HashSet<>();

            var root = new Level(new BitSet(), 0);
            var ok = queue.offer(root);
            assert ok : "Queue offering failed";

            while (!queue.isEmpty()) {
                var level = queue.poll();
                assert level != null : "Element is null";
                if (level.current.equals(target)) {
                    result += level.turns;
                    break;
                }

                for (var button : buttons) {
                    var state = (BitSet) level.current.clone();
                    for (var bit : button) state.flip(bit);
                    if (!visited.contains(state)) {
                        var next = new Level(state, level.turns + 1);
                        visited.add(state);
                        queue.offer(next);
                    }
                }
            }
        }

        return result;
    }

    public static int second(List<String> data) {
        return 0;
    }
}
