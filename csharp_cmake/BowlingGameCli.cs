using System;
using System.IO;
using BowlingGameNameSpace;

class Program
{
    static void Main(string[] args)
    {
        // 引数の数を確認
        if (args.Length != 1)
        {
            Console.WriteLine("Usage: " + System.AppDomain.CurrentDomain.FriendlyName + " <input_file>");
            Environment.ExitCode = 1;
            return;
        }

        string filePath = args[0];

        // ファイルが存在するか確認
        if (!File.Exists(filePath))
        {
            Console.WriteLine("File not found: " + filePath);
            Environment.ExitCode = 1;
            return;
        }

        BowlingGame bg = new BowlingGame();

        try
        {
            // ファイルを1行ずつ読み込み、各行の整数値を2倍して出力
            using (StreamReader sr = new StreamReader(filePath))
            {
                string line;
                while ((line = sr.ReadLine()) != null)
                {
                    if (int.TryParse(line, out int number))
                    {
                        if (number < 0)
                        {
                          break;
                        }
                        bg.roll(number);
                    }
                    else
                    {
                        Console.WriteLine("Invalid number format: " + line);
                        Environment.ExitCode = 1;
                        return;
                    }
                }
            }

            // 負の値が見つからなかった場合、最後に合計値を出力して終了
            Console.WriteLine(bg.score());
        }
        catch (Exception ex)
        {
            Console.WriteLine("An error occurred: " + ex.Message);
            Environment.ExitCode = 1;
        }
    }
}
