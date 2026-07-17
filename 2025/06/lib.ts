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
    const parse = (s: string) => s.split(" ").filter((d) => d != "");
    let result = 0;

    const operations = parse(data.pop() ?? "");
    const length = operations.length;
    const operands: number[][] = [];

    let k = 0;
    const m = data.length;
    const n = Math.max(...data.map((r) => r.length));

    // Iterate Horizontally
    for (let j = 0; j < n; j++) {
        let digits = "";
        for (let i = 0; i < m; i++) {
            let c = data[i]![j];
            if (c && c != " ") digits += c;
        }

        if (digits == "") k++;
        else if (operands[k]) operands[k]!.push(parseInt(digits));
        else operands.push([parseInt(digits)]);
    }

    for (let i = 0; i < length; i++) {
        const op = operations[i];
        const ab = operands[i];

        if (!ab || !op) continue;

        switch (op) {
            case "+": {
                result += ab.reduce((a, b) => a + b, 0);
                continue;
            }

            case "-": {
                result += ab.reduce((a, b) => a - b, 0);
                continue;
            }

            case "*": {
                result += ab.reduce((a, b) => a * b, 1);
                continue;
            }

            case "/": {
                result += ab.reduce((a, b) => a * b, 1);
                continue;
            }
        }
    }

    return result;
}
