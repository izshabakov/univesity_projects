import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.rmi.NotBoundException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

public class AuthController {
    //public static final String UNIC_BINDING_NAME = "server.request";
    //public static final String UNIC_BINDING_NAME1 = "server.hashpass";
    @FXML
    TextField login;
    @FXML
    PasswordField password;
    @FXML
    Button authbtn;
    @FXML
    Button regbtn;
    @FXML
    Label authlabel;
    static Integer id;

    @FXML
    void AuthClick() throws IOException, NoSuchAlgorithmException {
        try (Phone phone = new Phone("127.0.0.1", 8080)) {
            System.out.println("Connected to Server");
            final Registry registry = LocateRegistry.getRegistry(1888);
            Reverse service = (Reverse) registry.lookup(Client.UNIC_BINDING_NAME);
            //Reverse service1 = (Reverse) registry.lookup(UNIC_BINDING_NAME1);====
            id = service.RequestId("select Id from users \n" +
                    "where users.Login='" + login.getText() + "' AND users.Password='" + service.hashPass(password.getText()) + "'");
        } catch (SQLException e) {
            authlabel.setText("Такого аккаунта не существует");
            return;
        } catch (NotBoundException e) {
            authlabel.setText("Серверная ошибка");
        }


        Stage stage = (Stage) authbtn.getScene().getWindow();
        stage.close();
        Stage menustage=Client.StageGenerator("Menu");
        menustage.show();
    }

    @FXML
    void RegClick() throws IOException {
            Stage authstage = (Stage) regbtn.getScene().getWindow();
            Stage regstage = Client.StageGenerator("Registration");
            regstage.initModality(Modality.WINDOW_MODAL);
            regstage.initOwner(authstage);
            regstage.show();
    }
}


