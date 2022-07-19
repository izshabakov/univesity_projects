package com.company;

public class Polyline extends OpenFigure
{
    Point2D[] array;
    int n;

    Polyline(Point2D[] array, int n)
    {
        this.array = array;
        this.n = n;
    }

    public double Length()
    {
        double S = 0;
        for (int i = 0; i < n - 1; i++)
            S += Point2D.leng(array[i], array[i + 1]);
        return S;
    }

    public OpenFigure Shift(Point2D a)
    {
        Polyline buf = new Polyline(array, n);
        for (int i = 0; i < n; i++)
            buf.array[i] = (Point2D) buf.array[i].Add(a);
        return buf;
    }

    public OpenFigure Rot(double phi)
    {
        Polyline buf = new Polyline(array, n);
        for (int i = 0; i < n; i++)
            buf.array[i] = (Point2D) buf.array[i].Rot(phi);
        return buf;
    }

    public OpenFigure Symaxis(int i)
    {
        Polyline buf = new Polyline(array, n);
        for (int j = 0; j < n; j++)
            buf.array[j] = (Point2D) buf.array[j].Simm(i);
        return buf;
    }

    public boolean Cross(IShape a)
    {
        Polyline pol = (Polyline) a;
        for (int i = 0; i < this.n - 1; i++)
            for (int j = 0; j < pol.n - 1; j++)
                if (new Section(this.array[i], this.array[i + 1]).Cross(new Section(pol.array[j], pol.array[j + 1])))
                    return true;
        return false;
    }

}
