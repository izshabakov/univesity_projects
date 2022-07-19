import javafx.fxml.FXML;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.XYChart;

public class ErrorController {
    @FXML
    LineChart linechartError;

    @FXML
    public void initialize() {
        XYChart.Series learningSeries = new XYChart.Series();
        XYChart.Series trueSeries = new XYChart.Series();
        for (int i = 7; i < MenuController.learningdatas.size(); i = i + 8) {
            learningSeries.getData().add(new XYChart.Data(String.valueOf(MenuController.learningdatas.get(i).getDay()), MNK.error.get(i)));
            trueSeries.getData().add(new XYChart.Data(String.valueOf(MenuController.learningdatas.get(i).getDay()), MenuController.learningdatas.get(i).getTemp()));
        }
        learningSeries.setName("Эксп. значения");
        trueSeries.setName("Истин. значения");
        linechartError.getData().add(learningSeries);
        linechartError.getData().add(trueSeries);
    }
}
