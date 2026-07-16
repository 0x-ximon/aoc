export function first(data: string[]): number {
    const parse = (s: string) => s.split(" ").filter((d) => d != "");
    let result = 0;

    let top = parse(data[0] ?? "").map((s) => parseInt(s));
    const operations = parse(data.pop() ?? "");

    for (let i = 1; i < data.length; i++) {
        let bottom = parse(data[i] ?? "").map((s) => parseInt(s));
        for (let j = 0; j < bottom.length; j++) {
            const a = top[j];
            const b = bottom[j];
            const op = operations[j];
            if (!a || !b || !op) continue;

            switch (op) {
                case "+": {
                    top[j] = a + b;
                    continue;
                }

                case "-": {
                    top[j] = a - b;
                    continue;
                }

                case "*": {
                    top[j] = a * b;
                    continue;
                }

                case "/": {
                    top[j] = a / b;
                    continue;
                }
            }
        }
    }

    for (let n of top) result += n;
    return result;
}

export function second(data: string[]): number {
    return 0;
}
