package com.company;

public class Point
{
    protected int dim;
    protected double[] x;

    @Override
    public String toString()
    {
        StringBuilder P = new StringBuilder();
        P.append("(");
        for (int i = 0; i < dim - 1; i++)
        {
            P.append(x[i]).append(";");
        }
        P.append(x[dim - 1]).append(")");
        return P.toString();
    }

    public Point(int dim)
    {
        this.dim = dim;
        this.x = new double[dim];
    }

    public Point(int dim, double[] x)
    {
        this.dim = dim;
        this.x = x.clone();
    }

    public int GetDim()
    {
        return dim;
    }

    public double[] GetX()
    {
        return x;
    }

    public double GetX(int i)
    {
        return x[i];
    }

    public void SetX(double[] x)
    {
        this.x = x;
    }

    public void SetX(int i, double x)
    {
        this.x[i] = x;
    }

    public double Abs()
    {
        double a = 0;
        for (double i : x)
        {
            a += i * i;
        }
        return Math.sqrt(a);
    }

    public Point Add(Point B)
    {
        if (dim != B.GetDim())
        {
            System.out.println("Точки несовместимы");
        }
        double[] x = new double[dim];
        for (int i = 0; i < dim; i++)
        {
            x[i] = this.x[i] + B.GetX(i);
        }
        return new Point(dim, x);
    }

    public static Point Add(Point A, Point B)
    {
        if (A.GetDim() != B.GetDim())
        {
            System.out.println("Точки несовместимы");
        }
        Point buf = A.clone();
        for (int i = 0; i < A.GetDim(); i++)
        {
            buf.SetX(i, A.GetX(i) + B.GetX(i));
        }
        return buf;
    }

    public Point Sub(Point B)
    {
        if (dim != B.GetDim())
        {
            System.out.println("Точки несовместимы");
        }
        double[] x = new double[dim];
        for (int i = 0; i < dim; i++)
        {
            x[i] = this.x[i] - B.GetX(i);
        }
        return new Point(dim, x);
    }

    public static Point Sub(Point A, Point B)
    {
        if (A.GetDim() != B.GetDim())
        {
            System.out.println("Точки несовместимы");
        }
        double[] x = new double[A.GetDim()];
        for (int i = 0; i < A.GetDim(); i++)
        {
            x[i] = A.GetX(i) - B.GetX(i);
        }
        return new Point(A.GetDim(), x);
    }

    public Point Mult(double r)
    {
        double[] x = new double[dim];
        for (int i = 0; i < dim; i++)
        {
            x[i] = this.x[i] * r;
        }
        return new Point(dim, x);
    }

    public static Point Mult(double r, Point A)
    {
        double[] x = new double[A.GetDim()];
        for (int i = 0; i < A.GetDim(); i++)
        {
            x[i] = A.GetX(i) * r;
        }
        return new Point(A.GetDim(), x);
    }

    public double Multi(Point B)
    {
        if (dim != B.GetDim())
        {
            System.out.println("Точки несовместимы");
        }
        double a = 0;
        for (int i = 0; i < dim; i++)
        {
            a += x[i] * B.GetX(i);
        }
        return a;
    }

    public static double Multi(Point A, Point B)
    {
        if (A.GetDim() != B.GetDim())
        {
            System.out.println("Точки несовместимы");
        }
        double a = 0;
        for (int i = 0; i < A.GetDim(); i++)
        {
            a += A.GetX(i) * B.GetX(i);
        }
        return a;
    }

    public Point Simm(int n)
    {
        Point buf = this.clone();
        for (int i = 0; i < dim; i++)
        {
            buf.SetX(i, -this.x[i]);
        }
        buf.SetX(n, -this.x[n]);
        return buf;
    }

    public static double leng(Point A, Point B)
    {
        return (Point.Sub(A, B).Abs());
    }

    public Point clone()
    {
        return new Point(this.dim, this.x);
    }
}
