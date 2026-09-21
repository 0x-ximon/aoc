void main() {






    string[] data = File.ReadAllLines("input.txt");

    Int64 firstAnswer = Lib.first(data);
    Console.WriteLine(String.Format("First Answer: {0}", firstAnswer));

    Int64 secondAnswer = Lib.second(data);
    Console.WriteLine(String.Format("Second Answer: {0}", secondAnswer));
}

main();
