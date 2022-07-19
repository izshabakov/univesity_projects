package com.company;

import java.util.Scanner;

import static com.company.Point.*;
import static java.lang.Math.PI;

public class Circle implements IShape
{
    private double R;
    private Point2D X;

    public Circle(Point2D O, double R)
    {
        this.X = O;
        this.R = R;
    }

    public void SetC(double m[])
    {
        X.SetX(m);
    }

    public double Square()
    {
        return R * R * PI;
    }

    public double Length()
    {
        return 2 * R * PI;
    }

    public Point GetC()
    {
        return this.X;
    }

    public double GetR()
    {
        return R;
    }

    public void setR(double r)
    {
        R = r;
    }

    public IShape Shift(Point2D a)
    {
        return new Circle((Point2D) Add(X, a), this.R);
    }

    public IShape Rot(double b)
    {
        return new Circle((Point2D) X.Rot(b), this.R);
    }

    public IShape Symaxis(int N)
    {
        return new Circle((Point2D) X.Simm(N), this.R);
    }

    public String toString()
    {
        return "{" + X.toString() + ", R = " + R;
    }

    public boolean Cross(IShape a)
    {
        Circle Cir = (Circle) a;
        if (Cir.GetR() + this.GetR() >= Point.Sub(Cir.GetC(), this.GetC()).Abs())
        {
            return true;
        } else
            return false;
    }
}