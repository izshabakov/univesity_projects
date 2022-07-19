import java.io.*;
import java.net.ServerSocket;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

public class Server {
    public static final String UNIC_BINDING_NAME = "server.request";
    public static DB service = null;

    public static void main(String[] args) {
        try (ServerSocket server = new ServerSocket(8080);) {
            System.out.println("Server started");
            while (true) {
                Phone phone = new Phone(server);
                new Thread(() -> {
                    System.out.println("Client was connected");
                    try {
                        service = new DB();
                        final Registry registry = LocateRegistry.createRegistry(1888);
                        Remote stub = UnicastRemoteObject.exportObject(service, 0);
                        registry.rebind(UNIC_BINDING_NAME, stub);
                        try {
                            Thread.sleep(4000);
                        } catch (InterruptedException e) {
                        }
                        try {
                            phone.close();
                        } catch (IOException e) {
                        }
                    } catch (RemoteException e) {
                    }
                }).start();
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}