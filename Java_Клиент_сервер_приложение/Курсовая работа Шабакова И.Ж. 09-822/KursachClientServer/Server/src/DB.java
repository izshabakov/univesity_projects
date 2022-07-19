import java.io.Closeable;
import java.io.IOException;
import java.rmi.RemoteException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.sql.DriverManager;
import java.util.ArrayList;

public class DB implements Reverse, Closeable {
    private static final String url = "jdbc:mysql://localhost:3306/kursach" + "?verifyServerCertificate=false" + "&useSSL=false" + "&requireSSL=false" + "&useLegacyDatetimeCode=false" + "&amp" + "&serverTimezone=UTC";
    private static final String user = "root";
    private static final String password = "28nogai122812";
    public static Connection con;
    public static Statement stmt;
    private static ResultSet rs;

    public DB() {
        try {
            con = DriverManager.getConnection(url, user, password);
            stmt = con.createStatement();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void BatchUpdate(ArrayList<String> sql) throws SQLException {
        con.setAutoCommit(false);
        for (String s : sql)
            stmt.addBatch(s);
        stmt.executeBatch();
        con.commit();
    }

    @Override
    public int RequestId(String query) throws RemoteException, SQLException {
        int id;
        rs = stmt.executeQuery(query);
        rs.next();
        id = rs.getInt(1);
        return id;
    }

    @Override
    public void RequestDatas(String query) throws RemoteException, SQLException {
        stmt.executeQuery(query);
        rs = stmt.executeQuery(query);
    }

    @Override
    public void Update(String query) throws RemoteException, SQLException {
        stmt.executeUpdate(query);
    }

    @Override
    public String hashPass(String password) {
        try {
            MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
            String salt = "some_random_salt";
            String passWithSalt = password + salt;
            byte[] passBytes = passWithSalt.getBytes();
            byte[] passHash = sha256.digest(passBytes);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < passHash.length; i++) {
                sb.append(Integer.toString((passHash[i] & 0xff) + 0x100, 16).substring(1));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void close() {
        try {
            con.close();
            stmt.close();
            rs.close();
        } catch (SQLException e) {
        }
    }
}
