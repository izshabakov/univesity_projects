import javafx.application.Application;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import java.io.IOException;

public class Client extends Application {
    public static final String UNIC_BINDING_NAME = "server.request";

    @Override
    public void start(Stage primaryStage) throws Exception {
        primaryStage = StageGenerator("Authorization");
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }

    public static Stage StageGenerator(String stage) throws IOException {
        Stage genStage = new Stage();
        Parent root = FXMLLoader.load(Client.class.getResource(stage + ".fxml"));
        genStage.setTitle(stage);
        genStage.setScene(new Scene(root));
        genStage.getIcons().add(new Image(Client.class.getResourceAsStream(stage + ".png")));
        return genStage;
    }

}
