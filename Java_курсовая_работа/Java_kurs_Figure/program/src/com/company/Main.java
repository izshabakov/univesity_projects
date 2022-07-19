package com.company;

import java.util.*;


public class Main
{
    public static void main(String[] args)
    {
        String buf;
        double S = 0, L = 0;
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        IShape[] s1 = new IShape[n];
        String[] m = new String[n];
        for (int i = 0; i < n; i++)
        {
            m[i] = in.next();
            s1[i] = Parse(m[i]);
            if (s1[i] == null)
            {
                System.out.println("Фигура неизвестна");
                i--;
                continue;
            }
            S += Math.abs(s1[i].Square());
            L += Math.abs(s1[i].Length());
        }
        System.out.println("Общая площадь= " + S);
        System.out.println("Средняя площадь= " + S / n);
        System.out.println("Общая длина= " + L);
        System.out.println("Средняя длина= " + L / n);
        IShape[] s2 = new IShape[n];
        for (int i = 0; i < n; i++)
        {
            s2[i] = Parse(m[i]);

            for (int j = 0; j < n; j++)
                System.out.println("Суждение о том, пересекаются ли фигуры 1." + j + " и 2." + i + "  " + s2[i].Cross(s1[j]));

            buf = in.next();
            if (buf.equals("0"))
            {
                s2[i] = s2[i].Shift(new Point2D(new double[]{in.nextDouble(), in.nextDouble()}));
            } else if (buf.equals("1"))
            {
                s2[i] = s2[i].Rot(in.nextDouble());
            } else if (buf.equals("2"))
            {
                s2[i] = s2[i].Symaxis(in.nextInt());
            }
            System.out.println("Вот что вышло:");
            System.out.println(s2[i]);
            System.out.println();
            System.out.println("Суждение о том, пересекаются ли фигуры 1." + i + " и 2." + i + "  " + s2[i].Cross(s1[i]));
        }
    }

    public static IShape Parse(String s)
    {
        Scanner in = new Scanner(System.in);
        if (s.equals("0"))
            return new Circle(new Point2D(new double[]{in.nextDouble(), in.nextDouble()}), in.nextDouble());
        else if (s.equals("1"))
            return new Section(new Point2D(new double[]{in.nextDouble(), in.nextDouble()}), new Point2D(new double[]{in.nextDouble(), in.nextDouble()}));
        else if (s.equals("2"))
        {
            int n = in.nextInt();
            Point2D[] array = new Point2D[n];
            for (int i = 0; i < n; i++)
                array[i] = new Point2D(new double[]{in.nextDouble(), in.nextDouble()});
            return new Polyline(array, n);
        } else if (s.equals("3"))
        {
            int n = in.nextInt();
            Point2D[] array = new Point2D[n];
            for (int i = 0; i < n; i++)
                array[i] = new Point2D(new double[]{in.nextDouble(), in.nextDouble()});
            return new NGon(n, array);
        } else if (s.equals("4"))
        {
            Point2D[] array = new Point2D[3];
            for (int i = 0; i < 3; i++)
                array[i] = new Point2D(new double[]{in.nextDouble(), in.nextDouble()});
            return new TGon(array);
        } else if (s.equals("5"))
        {
            Point2D[] array = new Point2D[4];
            for (int i = 0; i < 4; i++)
                array[i] = new Point2D(new double[]{in.nextDouble(), in.nextDouble()});
            return new QGon(array);
        } else if (s.equals("6"))
        {
            Point2D[] array = new Point2D[4];
            for (int i = 0; i < 4; i++)
                array[i] = new Point2D(new double[]{in.nextDouble(), in.nextDouble()});
            return new Rectangle(array);
        } else if (s.equals("7"))
        {
            Point2D[] array = new Point2D[4];
            for (int i = 0; i < 4; i++)
                array[i] = new Point2D(new double[]{in.nextDouble(), in.nextDouble()});
            return new Trapeze(array);
        } else
            return null;
    }
}
