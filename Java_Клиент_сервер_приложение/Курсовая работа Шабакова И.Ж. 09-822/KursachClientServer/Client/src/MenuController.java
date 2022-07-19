import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Modality;
import javafx.stage.Stage;
import java.io.*;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

public class MenuController {
    private ObservableList<Data> datas = FXCollections.observableArrayList();
    static ObservableList<Data> learningdatas = FXCollections.observableArrayList();

    private double[] coef;
    private double[] results;

    @FXML
    Button lrnbtn;
    @FXML
    Button openbtn;
    @FXML
    Button loadbtn;
    @FXML
    Button predictbtn;
    @FXML
    Button downloadbtn;
    @FXML
    Button exit;
    @FXML
    NumberAxis yAxis;
    @FXML
    LineChart lineChart;
    @FXML
    ComboBox<String> comboBox;
    @FXML
    TextField textfield;
    @FXML
    TableView tableView;
    @FXML
    TableColumn year;
    @FXML
    TableColumn month;
    @FXML
    TableColumn day;
    @FXML
    TableColumn wind;
    @FXML
    TableColumn wet;
    @FXML
    TableColumn pressure;

    @FXML
    private void OpenFile() {
        try {
            textfield.setText(FileWork.OpenFile());
        } catch (NullPointerException e) {
            Alert error = new Alert(Alert.AlertType.ERROR);
            error.setContentText("Пустое поле");
            error.show();
        }
    }

    @FXML
    void Learning() throws IOException {
        learningdatas.clear();
        try (BufferedReader br = new BufferedReader(new FileReader(FileWork.OpenFile()))) {
            String s;
            String[] splitarray;
            while ((s = br.readLine()) != null) {
                splitarray = s.split("\\s*;\\s*");
                learningdatas.add(new Data(Integer.parseInt(splitarray[1]), Integer.parseInt(splitarray[2]), Integer.parseInt(splitarray[3]),
                        Integer.parseInt(splitarray[5]), Double.parseDouble(splitarray[8]),
                        Integer.parseInt(splitarray[10]), Double.parseDouble(splitarray[12])));
            }
        } catch (IOException | NumberFormatException | NullPointerException | ArrayIndexOutOfBoundsException e) {
            Alert error = new Alert(Alert.AlertType.ERROR);
            error.setContentText("Неверный путь/формат файла");
            error.show();
            return;
        }
        //ВЫЧИСЛЕНИЕ КОЭФФИЦЕНТОВ, ПОСЛЕ ЧЕГО В ОБСЕРВЛИСТ В КЛАССЕ MNK ДОБАВЛЯЮТСЯ ЭКСПЕРИМЕНТАЛЬНЫЕ ЗНАЧЕНИЯ. В ERR
        coef = MNK.Coef().clone();
        Stage lchartError = Client.StageGenerator("LinechartError");
        lchartError.initModality(Modality.WINDOW_MODAL);
        lchartError.initOwner(loadbtn.getScene().getWindow());
        lchartError.show();

    }

    @FXML
    void DFile() {
        try (BufferedReader br = new BufferedReader(new FileReader(textfield.getText()))) {
            datas.clear();

            String s;
            String[] splitarray;
            while ((s = br.readLine()) != null) {
                splitarray = s.split("\\s*;\\s*");
                datas.add(new Data(Integer.parseInt(splitarray[1]), Integer.parseInt(splitarray[2]), Integer.parseInt(splitarray[3]),
                        Integer.parseInt(splitarray[5]),
                        Integer.parseInt(splitarray[8]), Double.parseDouble(splitarray[10])));
            }

            if (!learningdatas.isEmpty())
                predictbtn.setDisable(false);

        } catch (IOException | NumberFormatException | NullPointerException | ArrayIndexOutOfBoundsException e) {
            Alert error = new Alert(Alert.AlertType.ERROR);
            predictbtn.setDisable(true);
            error.setContentText("Неправильный путь/формат файла");
            error.show();
            return;
        }

        Table();
        Graphic();
    }

    @FXML
    void Graphic() {
        lineChart.getData().removeAll(Collections.singleton(lineChart.getData().setAll()));
        yAxis.setAutoRanging(false);
        lineChart.setLegendVisible(false);
        XYChart.Series series = new XYChart.Series();
        String boxvalue = comboBox.getValue();
        series.setName(boxvalue);
        for (int i = 7; i < datas.size(); i = i + 8) {
            if (boxvalue.equals("Ветер")) {
                series.getData().add(new XYChart.Data(String.valueOf(datas.get(i).getDay()), datas.get(i).getWind()));
                yAxis.setLowerBound(0);
                yAxis.setTickUnit(1);
                yAxis.setUpperBound(10);
            }
            if (boxvalue.equals("Влажность")) {
                series.getData().add(new XYChart.Data(String.valueOf(datas.get(i).getDay()), datas.get(i).getWet()));
                yAxis.setLowerBound(0);
                yAxis.setTickUnit(5);
                yAxis.setUpperBound(100);
            }
            if (boxvalue.equals("Давление")) {
                series.getData().add(new XYChart.Data(String.valueOf(datas.get(i).getDay()), datas.get(i).getPressure()));
                yAxis.setAutoRanging(false);
                yAxis.setLowerBound(940);
                yAxis.setTickUnit(20);
                yAxis.setUpperBound(1060);
            }
        }
        lineChart.getData().add(series);
    }

    void Table() {
        year.setCellValueFactory(new PropertyValueFactory<Data, String>("year"));
        month.setCellValueFactory(new PropertyValueFactory<Data, String>("month"));
        day.setCellValueFactory(new PropertyValueFactory<Data, String>("day"));
        wind.setCellValueFactory(new PropertyValueFactory<Data, String>("wind"));
        wet.setCellValueFactory(new PropertyValueFactory<Data, String>("wet"));
        pressure.setCellValueFactory(new PropertyValueFactory<Data, String>("pressure"));
        tableView.setItems(datas);
    }

    @FXML
    void Predict() throws RemoteException, NotBoundException, SQLException {
        final Registry registry = LocateRegistry.getRegistry(1888);
        Reverse service = (Reverse) registry.lookup(Client.UNIC_BINDING_NAME);
        ArrayList<String> querys = new ArrayList<>();
        results = new double[datas.size()];

        for (int i = 0; i < datas.size(); i++) {
            double rawRes = datas.get(i).getWind() * coef[0] + datas.get(i).getWet() * coef[1] + datas.get(i).getPressure() * coef[2];
            results[i] = Double.parseDouble(String.format(Locale.ENGLISH, "%.1f", rawRes));
            querys.add("insert into data(wind,wet,pressure,TempRes,user_id) \n" + "values ('" + datas.get(i).getWind() + "','" + datas.get(i).getWet() + "','" + datas.get(i).getPressure() + "','" + results[i] + "','" + AuthController.id + "');");
        }
        service.BatchUpdate(querys);

        downloadbtn.setDisable(false);
        predictbtn.setDisable(true);
    }

    @FXML
    void Download() throws IOException {
        Date date1 = new Date();
        SimpleDateFormat formatForDateNow = new SimpleDateFormat("dd-MM-yy_hh-mm-ss-a");
        String cc = formatForDateNow.format(date1);
        String path = FileWork.Directory();
        File file = new File(path, cc + ".txt");
        try (FileWriter out = new FileWriter(file)) {

            int i = 0;
            while (i < datas.size()) {
                String s = datas.get(i).toString();
                out.write(s + " Прогноз погоды:" + results[i] + "°C");
                out.append('\n');
                i++;
            }
            out.flush();
        }
    }

    @FXML
    void Exit() throws IOException {
        Stage menustage = (Stage) loadbtn.getScene().getWindow();
        menustage.close();
        Stage authstage = Client.StageGenerator("Authorization");
        authstage.show();
    }
}