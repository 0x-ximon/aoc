package ximon;

import java.util.ArrayList;
import java.util.BitSet;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Lib {
    public static int first(final List<String> data) {
        var result = 0;

        for (final var line : data) {
            var k = 0;
            var p = 0;
            var q = 0;

            final var target = new BitSet(); // Square Brackets
            while (q < line.length()) {
                final var token = line.charAt(q);
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

            final var buttons = new ArrayList<ArrayList<Integer>>(); // Round Brackets
            while (q < line.length()) {
                final var token = line.charAt(q);
                if (token == '{') break;

                if (token == '(') p = q;
                if (token == ')') {
                    final var button = new ArrayList<Integer>();
                    final var ss = line.substring(p + 1, q).split(",");
                    for (final var s : ss) button.add(Integer.parseInt(s));
                    buttons.add(button);
                }

                q++;
            }

            final var joltage = new ArrayList<Integer>(); // Curly Brackets
            while (q < line.length()) {
                final var token = line.charAt(q);
                if (token == '{') p = q;
                if (token == '}') {
                    final var ss = line.substring(p + 1, q).split(",");
                    for (final var s : ss) joltage.add(Integer.parseInt(s));
                    break;
                }

                q++;
            }

            // Breadth-first Search
            record Level(BitSet current, Integer turns) {}
            final Queue<Level> queue = new LinkedList<Level>();
            final HashSet<BitSet> visited = new HashSet<>();

            final var root = new BitSet();
            var ok = queue.offer(new Level(root, 0));
            assert ok : "Queue offering failed";

            while (!queue.isEmpty()) {
                final var level = queue.poll();
                assert level != null : "Element is null";
                if (level.current.equals(target)) {
                    result += level.turns;
                    break;
                }

                for (final var button : buttons) {
                    final var state = (BitSet) level.current.clone();

                    for (final var b : button) state.flip(b);
                    if (visited.contains(state)) continue;

                    ok = queue.offer(new Level(state, level.turns + 1));
                    assert ok : "Queue offering failed";
                    visited.add(state);
                }
            }
        }

        return result;
    }

    public static int second(final List<String> data) {
        var result = 0;

        for (final var line : data) {
            var p = 0;
            var q = 0;
            var r = 0;

            final var indicators = new BitSet(); // Square Brackets
            while (q < line.length()) {
                final var token = line.charAt(q);
                if (token == '[') p = q;
                if (token == ']') break;

                if (token == '.') {
                    indicators.clear(r);
                    r++;
                }

                if (token == '#') {
                    indicators.set(r);
                    r++;
                }

                q++;
            }

            final var buttons = new ArrayList<ArrayList<Integer>>(); // Round Brackets
            while (q < line.length()) {
                final var token = line.charAt(q);
                if (token == '{') break;

                if (token == '(') p = q;
                if (token == ')') {
                    final var button = new ArrayList<Integer>();
                    final var ss = line.substring(p + 1, q).split(",");
                    for (final var s : ss) button.add(Integer.parseInt(s));
                    buttons.add(button);
                }

                q++;
            }

            final var joltages = new ArrayList<Integer>(); // Curly Brackets
            while (q < line.length()) {
                final var token = line.charAt(q);
                if (token == '{') p = q;
                if (token == '}') {
                    final var ss = line.substring(p + 1, q).split(",");
                    for (final var s : ss) joltages.add(Integer.parseInt(s));
                    break;
                }

                q++;
            }

            final var combinations = new ArrayList<ArrayList<ArrayList<Integer>>>();
            for (var i = 0; i < 1 << buttons.size(); i++) { // 2^n
                final var s = new ArrayList<ArrayList<Integer>>();

                for (var j = 0; j < buttons.size(); j++) {
                    final var k = 1 << j;
                    if ((i & k) != 0) s.add(buttons.get(j));
                }

                combinations.add(s);
            }

            final var parities = new HashMap<BitSet, HashSet<Pattern>>();
            for (final var combination : combinations) {
                final var empty = Collections.nCopies(joltages.size(), 0);
                final var effects = new ArrayList<Integer>(empty);
                final var parity = new BitSet();

                for (final var button : combination) {
                    for (final var b : button) {
                        effects.set(b, effects.get(b) + 1);
                    }
                }

                for (int i = 0; i < joltages.size(); i++) {
                    if (effects.get(i) % 2 == 1) parity.flip(i);
                }
                parities.computeIfAbsent(parity, bucket -> new HashSet<>())
                        .add(new Pattern(combination.size(), effects));
            }

            final var memo = new HashMap<ArrayList<Integer>, Integer>();

            result += explore(joltages, memo, parities);
        }

        return result;
    }

    public record Pattern(int cost, ArrayList<Integer> effects) {}

    static int explore(
            ArrayList<Integer> state,
            HashMap<ArrayList<Integer>, Integer> memo,
            HashMap<BitSet, HashSet<Pattern>> parities) {
        if (state.stream().allMatch(s -> s == 0)) return 0;
        if (memo.containsKey(state)) return memo.get(state);

        int INF = 1_000_000_000;
        int result = INF;

        var parity = new BitSet();
        for (var i = 0; i < state.size(); i++) {
            if (state.get(i) % 2 == 1) parity.set(i);
        }

        var patterns = parities.get(parity);
        if (patterns == null) return result;

        outer:
        for (var pattern : patterns) {
            final var next = new ArrayList<>(state);
            for (int i = 0; i < state.size(); i++) {
                if (pattern.effects.get(i) > state.get(i)) continue outer;
                next.set(i, (state.get(i) - pattern.effects.get(i)) / 2);
            }

            var r = explore(next, memo, parities);
            if (r == INF) continue;
            result = Math.min(result, pattern.cost + 2 * r);
        }

        memo.put(state, result);
        return result;
    }
}
