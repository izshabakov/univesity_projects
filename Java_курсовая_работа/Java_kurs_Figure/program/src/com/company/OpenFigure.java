package com.company;

import static com.company.Point.*;

public abstract class OpenFigure implements IShape
{
    public double Square()
    {
        return 0;
    }

    public abstract double Length();

    public abstract OpenFigure Shift(Point2D a);

    public abstract OpenFigure Rot(double phi);

    public abstract OpenFigure Symaxis(int i);

    public abstract boolean Cross(IShape i);
}