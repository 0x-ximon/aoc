struct Point
{
    public Int64 x;
    public Int64 y;
}

class Lib
{
    public static Int64 first(string[] data)
    {
        Int64 result = 0;

        int m = data.Length;
        int n = data[0].Length;

        List<Point> points = new List<Point>();
        foreach (string line in data)
        {
            Point p = new Point();
            string[] chunks = line.Split(",");
            p.x = int.Parse(chunks[0]);
            p.y = int.Parse(chunks[1]);
            points.Add(p);
        }

        for (int i = 0; i < points.Count; i++)
        {
            for (int j = i + 1; j < points.Count; j++)
            {
                Point p = points[i];
                Point q = points[j];

                Int64 width = Math.Abs(q.x - p.x) + 1;
                Int64 height = Math.Abs(q.y - p.y) + 1;
                Int64 area = width * height;
                result = Math.Max(area, result);
            }
        }

        return result;
    }

    public static Int64 second(string[] data)
    {
        return 0;
    }
}
