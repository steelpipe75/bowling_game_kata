require_relative 'bowling_game'

# 引数が指定されていない場合は使い方を表示
if ARGV.empty?
  puts "Usage: ruby main.rb filename"
  exit
end

filename = ARGV[0]
bg = BowlingGame.new

# ファイルを読み込んで処理
File.open(filename, "r") do |file|
  file.each_line do |line|
    # 行から整数を取得
    num = line.chomp.to_i

    # 負の値なら終了
    if num < 0
      break
    end

    # 二倍して出力
    bg.roll(num)
  end
end

puts bg.score
