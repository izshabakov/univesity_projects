package com.company;

public class NGon implements IShape {
    Point2D[] array;
    int n;

    NGon(int n, Point2D[] array) {
        this.array = array;
        this.n = n;
    }

    @Override
    public double Square() {
        double S = array[n - 1].GetX(0) * array[0].GetX(1) - array[0].GetX(0) * array[n - 1].GetX(1);
        for (int i = 0; i < n - 1; i++)
            S += array[i].GetX(0) * array[i + 1].GetX(1) - array[i + 1].GetX(0) * array[i].GetX(1);
        return S / 2;
    }

    @Override
    public double Length() {
        double S = Point.Sub(array[0], array[n - 1]).Abs();
        for (int i = 0; i < n - 1; i++) {
            S += Point.Sub(array[i], array[i + 1]).Abs();
        }
        return S;
    }

    @Override
    public IShape Shift(Point2D a) {
        NGon buf = new NGon(this.n, this.array);
        for (int i = 0; i < n; i++)
            buf.array[i] = (Point2D) Point.Add(buf.array[i], a);
        return buf;
    }

    @Override
    public IShape Rot(double phi) {
        NGon buf = new NGon(this.n, this.array);
        for (int i = 0; i < n; i++)
            buf.array[i] = (Point2D) buf.array[i].Rot(phi);
        return buf;
    }

    @Override
    public IShape Symaxis(int i) {
        NGon buf = new NGon(this.n, this.array);
        for (int j = 0; j < n; j++)
            buf.array[j] = (Point2D) buf.array[j].Simm(i);
        return buf;
    }

    @Override
    public boolean Cross(IShape a) {
        NGon ngon = (NGon) a;
        for (int i = 0; i < this.n - 1; i++) {
            for (int j = 0; j < ngon.n - 1; j++) {
                if (new Section(this.array[i], this.array[i + 1]).Cross(new Section(ngon.array[j], ngon.array[j + 1])))
                    return true;
            }
            if (new Section(this.array[i], this.array[i + 1]).Cross(new Section(ngon.array[ngon.n - 1], ngon.array[0])))
                return true;
        }
        for (int j = 0; j < ngon.n - 1; j++) {
            if (new Section(this.array[this.n - 1], this.array[0]).Cross(new Section(ngon.array[j], ngon.array[j + 1])))
                return true;
        }
        if (new Section(this.array[this.n - 1], this.array[0]).Cross(new Section(ngon.array[ngon.n - 1], ngon.array[0])) || this.IsBelongs(ngon.array[0]) || ngon.IsBelongs(array[0]))
            return true;
        return false;
    }

    public boolean IsBelongs(Point2D a) {
        for (int i = 0; i < n - 1; i++)
            if (new Section(array[i], array[i + 1]).WIP(a) != new Section(array[i], array[i + 1]).WIP(array[n - 1]))
                return false;
        if (new Section(array[n - 2], array[n - 1]).WIP(a) == new Section(array[n - 2], array[n - 1]).WIP(array[0]) && new Section(array[0], array[n - 1]).WIP(a) == new Section(array[0], array[n - 1]).WIP(array[1]))
            return true;
        else
            return false;
    }

    public String toString() {
        String s = "{";
        for (Point2D buf : array)
            s += buf.toString() + ",";
        return s.substring(0, s.length() - 1) + "}";
    }
}