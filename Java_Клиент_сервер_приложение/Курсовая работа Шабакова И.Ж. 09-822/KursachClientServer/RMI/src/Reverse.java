import java.rmi.Remote;
import java.rmi.RemoteException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;

interface Reverse extends Remote {
    void BatchUpdate(ArrayList<String> sql) throws RemoteException, SQLException;

    int RequestId(String query) throws RemoteException, SQLException;

    void RequestDatas(String query) throws RemoteException, SQLException;

    void Update(String query) throws RemoteException, SQLException;

    String hashPass(String pass) throws RemoteException, NoSuchAlgorithmException;
}