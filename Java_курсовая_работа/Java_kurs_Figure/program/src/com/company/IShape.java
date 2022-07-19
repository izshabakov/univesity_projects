package com.company;

public interface IShape
{
    double Square();

    double Length();

    public IShape Shift(Point2D a);

    public IShape Rot(double phi);

    public IShape Symaxis(int i);

    public boolean Cross(IShape i);
}