import Jama.Matrix;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

public class MNK {
    static ObservableList<Double> error = FXCollections.observableArrayList();

    public static double[] Coef() {
        double[] coef;
        int n = MenuController.learningdatas.size();
        double[][] x = new double[n][3];
        for (int i = 0; i < n; i++) {
            x[i][0] = MenuController.learningdatas.get(i).getWind();
            x[i][1] = MenuController.learningdatas.get(i).getWet();
            x[i][2] = MenuController.learningdatas.get(i).getPressure();
        }
        double[] y = new double[n];
        for (int i = 0; i < n; i++) {
            y[i] = MenuController.learningdatas.get(i).getTemp();
        }
        Matrix A1 = new Matrix(x);
        Matrix Y = new Matrix(y, y.length);
        Matrix B1 = A1.transpose();
        Matrix F1 = B1.times(A1);
        Matrix F4 = F1.inverse();
        Matrix F2 = F4.times(B1);
        Matrix F3 = F2.times(Y);
        coef = F3.getColumnPackedCopy();
        for (int i = 0; i < 3; i++)
            System.out.println("coef[" + i + "]=" + coef[i]);

        double[] error1 = new double[n];
        for (int i = 0; i < n; i++) {
            error.add(x[i][0] * coef[0] + x[i][1] * coef[1] + x[i][2] * coef[2]);
        }
        return coef;
    }
}
