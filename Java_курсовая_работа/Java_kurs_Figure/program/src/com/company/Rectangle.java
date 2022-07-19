package com.company;

public class Rectangle extends QGon
{
    public Rectangle(Point2D[] array)
    {
        super(array);
    }

    public double Square()
    {
        return Point.Sub(array[0], array[1]).Abs() * Point.Sub(array[0], array[3]).Abs();
    }
}