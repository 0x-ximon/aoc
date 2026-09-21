namespace tests;

[TestClass]
public sealed class TestMain
{
    string[] data = ["7,1", "11,1", "11,7", "9,7", "9,5", "2,5", "2,3", "7,3"];

    [TestMethod]
    public void TestFirst()
    {
        Int64 firstExpected = 50;
        Int64 firstActual = Lib.first(data);
        Assert.AreEqual(firstExpected, firstActual);
    }

    [TestMethod]
    public void TestSecond()
    {
        Int64 secondExpected = 24;
        Int64 secondActual = Lib.second(data);
        Assert.AreEqual(secondExpected, secondActual);
    }
}
