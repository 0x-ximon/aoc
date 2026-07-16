import fs from "node:fs";
import { first } from "./lib.ts";

function main() {
    const file = fs.readFileSync("input.txt", "utf-8");
    const data = file
        .split("\n")
        .map((line) => line.trimEnd())
        .filter((line) => line.length > 0);

    const firstAnswer = first(data);
    console.info(`First Answer: ${firstAnswer}`);
}

main();
