package com.company;

public class TGon extends NGon
{
    TGon(Point2D[] array)
    {
        super(3, array);
    }
    public double Square()
    {
     return (array[0].GetX(0) * (array[1].GetX(1) - array[2].GetX(1)) + array[1].GetX(0) * (array[2].GetX(1) - array[0].GetX(1)) + array[2].GetX(0) * (array[0].GetX(1) - array[1].GetX(1))) / 2;
    }
}
