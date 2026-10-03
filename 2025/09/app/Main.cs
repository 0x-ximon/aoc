void main()
{
    var data = File.ReadAllLines("input.txt");

    var firstAnswer = Lib.first(data);
    Console.WriteLine(String.Format("First Answer: {0}", firstAnswer));

    var secondAnswer = Lib.second(data);
    Console.WriteLine(String.Format("Second Answer: {0}", secondAnswer));
}

main();
