package com.company;

public class Point2D extends Point
{
    public Point2D()
    {
        super(2);
    }

    public Point2D(double[] x)
    {
        super(2, x);
    }

    public Point Rot(double a)
    {
        double[] x = new double[2];
        x[0] = this.x[0] * Math.cos(a) - this.x[1] * Math.sin(a);
        x[1] = this.x[0] * Math.sin(a) + this.x[1] * Math.cos(a);
        return new Point2D(x);
    }

    public Point2D clone()
    {
        return new Point2D(this.x);
    }
}