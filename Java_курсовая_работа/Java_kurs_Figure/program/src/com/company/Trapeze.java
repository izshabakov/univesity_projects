package com.company;

public class Trapeze extends QGon
{
    public Trapeze(Point2D[] array)
    {
        super(array);
    }

    @Override
    public double Square()
    {
        return (Point.Sub(array[0], array[1]).Abs() + Point.Sub(array[2], array[3]).Abs()) / 2 * (array[1].GetX(1) - array[0].GetX(1));
    }
}