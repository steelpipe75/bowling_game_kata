package steelpipe;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class App 
{
    public static void main(String[] args) {
        // コマンドライン引数でファイルパスが指定されているか確認
        if (args.length < 1) {
            System.out.println("ファイルパスを指定してください。");
            return;
        }

        String filePath = args[0];
        BowlingGame bg = new BowlingGame();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                try {
                    int num = Integer.parseInt(line);
                    if (num < 0) {
                        // System.out.println("負の値が見つかったため、プログラムを終了します。");
                        break;
                    }
                    bg.roll(num);
                } catch (NumberFormatException e) {
                    // System.out.println("整数以外の行が見つかったため、スキップします: " + line);
                }
            }
            System.out.println(bg.score());
        } catch (IOException e) {
            System.out.println("ファイルを読み取る際にエラーが発生しました: " + e.getMessage());
        }
    }
}
