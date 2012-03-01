import java.io.*;
import java.util.*;

public class floor4_md implements Runnable {
    private final static int MAX = 100000;
    private BufferedReader in;
    private PrintWriter out;

    public void run() {
        try {
            solve();
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    private void solve() throws IOException {
        Locale.setDefault(Locale.US);
        in = new BufferedReader(new FileReader("floor4.in"));
        out = new PrintWriter("floor4.out");
        TreeSet<Integer> free = new TreeSet<Integer>();
        for (int i = 1; i <= 2 * MAX; i++)
            free.add(i);
        int n = Integer.parseInt(in.readLine());
        for (int i = 1; i <= n; i++) {
            int a = Integer.parseInt(in.readLine());
            if (a < 0) {
                a = -a;
                if (free.contains(a)) {
                    out.println("ERROR: room already free, line " + i);
                    System.exit(1);
                }
                free.add(a);
                continue;
            }
            a = free.tailSet(a).first();
            free.remove(a);
            out.println(a);
        }
        in.close();
        out.close();
    }

    public static void main(String[] args) {
        new Thread(new floor4_md()).start();
    }
}
