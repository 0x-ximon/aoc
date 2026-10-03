record struct Pair(int i, int j);

record struct Point(int x, int y);

public class Lib
{
    public static Int64 first(string[] data)
    {
        Int64 result = 0;

        var m = data.Length;
        var n = data[0].Length;

        var points = new List<Point>();
        foreach (var line in data)
        {
            var p = new Point();
            var chunks = line.Split(",");
            p.x = int.Parse(chunks[0]);
            p.y = int.Parse(chunks[1]);
            points.Add(p);
        }

        for (int i = 0; i < points.Count - 1; i++)
        {
            for (int j = i + 1; j < points.Count; j++)
            {
                var p = points[i];
                var q = points[j];

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
        Int64 result = 0;

        // Declarations
        var points = new List<Point>();
        var compressed = new List<Point>();

        var grid = new List<List<Char>>();
        var table = new List<List<int>>();

        foreach (var line in data)
        {
            var p = new Point();
            var chunks = line.Split(",");
            p.x = int.Parse(chunks[0]);
            p.y = int.Parse(chunks[1]);
            points.Add(p);
        }

        // Coordinate Compression
        coordinateCompression(in points, ref compressed, ref grid);

        // Flood Fill
        floodFill(ref grid);

        // Prefix Sum
        prefixSum(in grid, ref table);

        for (int i = 0; i < points.Count - 1; i++)
        {
            for (int j = i + 1; j < points.Count; j++)
            {
                var p = points[i];
                var q = points[j];

                Int64 width = Math.Abs(q.x - p.x) + 1;
                Int64 height = Math.Abs(q.y - p.y) + 1;

                Int64 area = width * height;
                if (area <= result)
                    continue;

                var a = compressed[i];
                var b = compressed[j];

                var contained = lookup(table, a, b) == 0;
                if (contained)
                    result = area;
            }
        }

        return result;
    }

    private static void coordinateCompression(
        in List<Point> points,
        ref List<Point> compressed,
        ref List<List<Char>> grid
    )
    {
        var xp = points.Select(p => p.x).Distinct().ToList();
        var xd = new Dictionary<int, int>();
        var xs = new List<int?>();
        xp.Sort();

        var yp = points.Select(p => p.y).Distinct().ToList();
        var yd = new Dictionary<int, int>();
        var ys = new List<int?>();
        yp.Sort();

        for (var i = 0; i < xp.Count; i++)
        {
            var k = (2 * i) + 1;
            var x = xp[i];

            xs.Add(null);
            xs.Add(x);
            xd[x] = k;
        }

        for (var j = 0; j < yp.Count; j++)
        {
            var k = (2 * j) + 1;
            var y = yp[j];

            ys.Add(null);
            ys.Add(y);
            yd[y] = k;
        }

        xs.Add(null);
        ys.Add(null);

        // Grid Generation
        var w = xs.Count;
        var h = ys.Count;

        for (var j = 0; j < h; j++)
        {
            grid.Add(new List<Char>());
            for (var i = 0; i < w; i++)
                grid[j].Add('.');
        }

        foreach (var p in points)
        {
            var i = xd[p.x];
            var j = yd[p.y];
            grid[j][i] = '#';

            var q = new Point(i, j);
            compressed.Add(q);
        }

        var n = compressed.Count;
        for (var k = 0; k < n; k++)
        {
            var p = compressed[k];
            var q = compressed[(k + 1) % n];

            if (p.x == q.x)
            {
                var x = p.x;
                var start = Math.Min(p.y, q.y);
                var stop = Math.Max(p.y, q.y);

                for (var y = start + 1; y < stop; y++)
                    grid[y][x] = '#';
            }

            if (p.y == q.y)
            {
                var y = p.y;
                var start = Math.Min(p.x, q.x);
                var stop = Math.Max(p.x, q.x);

                for (var x = start + 1; x < stop; x++)
                    grid[y][x] = '#';
            }
        }
    }

    private static void floodFill(ref List<List<Char>> grid)
    {
        (int dx, int dy)[] directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        var m = grid.Count;
        var n = grid[0].Count;
        var q = new Queue<Pair>();

        var root = new Pair(0, 0);
        grid[0][0] = '*';
        q.Enqueue(root);

        while (q.Count != 0)
        {
            var (a, b) = q.Dequeue();
            foreach (var dir in directions)
            {
                var dx = dir.dx;
                var dy = dir.dy;

                var i = a + dx;
                var j = b + dy;

                if ((i >= 0 && j >= 0) && (i < m && j < n) && (grid[i][j] == '.'))
                {
                    grid[i][j] = '*';
                    q.Enqueue(new Pair(i, j));
                }
            }
        }
    }

    private static void prefixSum(in List<List<Char>> grid, ref List<List<int>> table)
    {
        var m = grid.Count + 1;
        var n = grid[0].Count + 1;

        for (int i = 0; i < m; i++)
        {
            table.Add(new List<int>());
            for (int j = 0; j < n; j++)
                table[i].Add(0);
        }

        for (int i = 0; i < m - 1; i++)
        {
            for (int j = 0; j < n - 1; j++)
            {
                var cell = grid[i][j] == '*' ? 1 : 0;
                table[i + 1][j + 1] = cell + table[i][j + 1] + table[i + 1][j] - table[i][j];
            }
        }
    }

    private static int lookup(in List<List<int>> table, Point p, Point q)
    {
        var i1 = Math.Min(p.y, q.y);
        var i2 = Math.Max(p.y, q.y);

        var j1 = Math.Min(p.x, q.x);
        var j2 = Math.Max(p.x, q.x);

        var A = table[i2 + 1][j2 + 1];
        var B = table[i1][j2 + 1];
        var C = table[i2 + 1][j1];
        var D = table[i1][j1];

        return A - B - C + D;
    }
}
