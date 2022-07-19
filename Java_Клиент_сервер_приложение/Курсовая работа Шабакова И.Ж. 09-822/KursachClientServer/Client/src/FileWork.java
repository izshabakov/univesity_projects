import javafx.stage.DirectoryChooser;
import javafx.stage.FileChooser;

import java.io.File;

public class FileWork  {
    public static String OpenFile(){
        String s;
        FileChooser fileChooser = new FileChooser();//Класс работы с диалогом выборки и сохранения
        fileChooser.setTitle("Open Document");//Заголовок диалога
        FileChooser.ExtensionFilter extFilter =
                new FileChooser.ExtensionFilter("TXT files (*.txt)", "*.txt");//Расширение
        fileChooser.getExtensionFilters().add(extFilter);
        File file = fileChooser.showOpenDialog(null);//Указываем текущую сцену CodeNote.mainStage
        s = file.toString();
        return s;
    }
    public static String Directory() throws NullPointerException {
        String s;
        DirectoryChooser directory= new DirectoryChooser();
        directory.setTitle("Choose Directory");//Заголовок диалога
        File file = directory.showDialog(null);//Указываем текущую сцену CodeNote.mainStage
        s = file.toString();
        return s;
    }
}
