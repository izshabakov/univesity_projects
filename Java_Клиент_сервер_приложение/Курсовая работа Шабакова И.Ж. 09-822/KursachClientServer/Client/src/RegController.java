
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

import java.io.IOException;
import java.rmi.NotBoundException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

public class RegController {
    //public static final String UNIC_BINDING_NAME = "server.request";
    //public static final String UNIC_BINDING_NAME1 = "server.hashpass";
    @FXML
    TextField LoginRegTextField;
    @FXML
    PasswordField PassRegField;
    @FXML
    Button RegButton;
    @FXML
    Label reglabel;

    @FXML
    void RegClick() throws IOException, NoSuchAlgorithmException {
        String login = LoginRegTextField.getText();
        String pass = PassRegField.getText();
        boolean loginresult = login.matches("\\w{6,16}");
        boolean passresult = pass.matches("\\w{6,16}");
        if (loginresult & passresult) {
            try (Phone phone = new Phone("127.0.0.1", 8080)) {
                System.out.println("Connected to Server");
                final Registry registry = LocateRegistry.getRegistry(1888);
                Reverse service = (Reverse) registry.lookup(Client.UNIC_BINDING_NAME);
                service.Update("insert into users(Login,Password) \n" + "values ('" + login + "','" + service.hashPass(pass) + "');");
            } catch (SQLException e) {
                reglabel.setText("Логин занят");
                return;
            } catch (NotBoundException e) {
                reglabel.setText("Серверная ошибка");
            }
            Stage stage = (Stage) RegButton.getScene().getWindow();
            stage.close();
        } else {
            reglabel.setTextFill(Color.RED);
            reglabel.setText("Логин/Пароль должен состоять \n не менее чем из 6 символов \n латицины или цифр");
        }
    }
}
