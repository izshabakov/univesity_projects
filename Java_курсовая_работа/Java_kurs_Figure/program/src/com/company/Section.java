package com.company;
public class Section extends OpenFigure
{
    Point2D st, f;

    Section(Point2D st, Point2D f)
    {
        this.st = st;
        this.f = f;
    }

    public String toString()
    {
        return (st.x[0] + ";" + st.x[1]) + " " + (f.x[0] + ";" + f.x[1]);
    }

    public Point2D getF()
    {
        return f;
    }

    public void setF(Point2D f)
    {
        this.f = f;
    }

    public Point2D getSt()
    {
        return st;
    }

    public void setSt(Point2D st)
    {
        this.st = st;
    }

    @Override
    public double Length()
    {
        return Point.Sub(st, f).Abs();
    }

    @Override
    public Section Shift(Point2D a)
    {
        Section buf = new Section(st, f);
        buf.st = (Point2D) buf.st.Add(a);
        buf.f = (Point2D) buf.f.Add(a);
        return buf;
    }

    @Override
    public OpenFigure Rot(double phi)
    {
        Section buf = new Section(st, f);
        buf.st = (Point2D) buf.st.Rot(phi);
        buf.f = (Point2D) buf.f.Rot(phi);
        return buf;
    }

    @Override
    public OpenFigure Symaxis(int i)
    {
        Section buf = new Section(st, f);
        buf.st = (Point2D) buf.st.Simm(i);
        buf.f = (Point2D) buf.f.Simm(i);
        return buf;
    }

    @Override
    public boolean Cross(IShape i)
    {
        Section sec = (Section) i;
        double k1 = (f.x[1] - st.x[1]) / (f.x[0] - st.x[0]), c1 = this.st.GetX(1) - this.st.GetX(0) * k1;
        double k2 = (sec.f.x[1] - sec.st.x[1]) / (sec.f.x[0] - sec.st.x[0]), c2 = sec.st.GetX(1) - sec.st.GetX(0) * k2;
        if (k1 != k2)
        {
            Point2D cross = new Point2D(new double[]{(c2 - c1) / (k1 - k2), (c2 - c1) / (k1 - k2) * k1 + c1});
            if (Point.Sub(this.st, cross).Abs() < this.Length() && Point.Sub(this.f, cross).Abs() < this.Length() && Point.Sub(sec.st, cross).Abs() < sec.Length() && Point.Sub(sec.f, cross).Abs() < sec.Length())
                return true;
        }
        return false;
    }

    //Where Is Point
    public short WIP(Point2D a)
    {
        double k = (f.x[1] - st.x[1]) / (f.x[0] - st.x[0]), c = this.st.GetX(1) - this.st.GetX(0) * k;
        if (a.GetX(1) > k * a.GetX(0) + c)
            return 1;
        else if (a.GetX(1) < k * a.GetX(0) + c)
            return -1;
        else
            return 0;
    }
}