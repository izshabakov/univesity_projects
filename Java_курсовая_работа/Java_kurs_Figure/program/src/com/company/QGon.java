package com.company;

import java.util.Scanner;

public class QGon extends NGon {
    QGon(Point2D[] k) {
        super(4, k);
    }

    @Override
    public double Square() {
        double P=(Point.Sub(array[0], array[1]).Abs()+Point.Sub(array[1],array[2]).Abs()+Point.Sub(array[2], array[3]).Abs()+Point.Sub(array[3], array[0]).Abs())/2;
        double A=Point.Sub(array[0], array[1]).Abs();
        double B=Point.Sub(array[1],array[2]).Abs();
        double C=Point.Sub(array[2], array[3]).Abs();
        double D=Point.Sub(array[3], array[0]).Abs();
         /*double angle1=Math.toDegrees(Math.atan2(array[3].GetX(1)-array[1].GetX(1),array[3].GetX(0)-array[1].GetX(0)));
         double angle2=Math.toDegrees(Math.atan2(array[2].GetX(1)-array[0].GetX(1),array[2].GetX(0)-array[0].GetX(0)));
     PROVERKA    */
         double angle3=Math.toDegrees(Math.atan2(A,B));
         double angle4=Math.toDegrees(Math.atan2(C,D));
        return Math.sqrt((P-A)*(P-B)*(P-C)*(P-D)-(A*B*C*D*(Math.cos((angle3+angle4)/2))*(Math.cos((angle3+angle4)/2))));

       /* SPOSOB NOMER 2
       double d1=Point.Sub(array[1],array[3]).Abs();
       double d2=Point.Sub(array[0],array[2]).Abs();
       double angle=Math.toDegrees(Math.atan2(d1,d2));
        double angle1=Math.atan2(array[3].GetX(1)-array[1].GetX(1),array[3].GetX(0)-array[1].GetX(0));
        double angle2=Math.atan2(array[2].GetX(1)-array[0].GetX(1),array[2].GetX(0)-array[0].GetX(0));
        double deltaangle=Math.toDegrees(angle1-angle2);
       return (d1*d2*Math.sin(deltaangle))/2;
       */
    }
}