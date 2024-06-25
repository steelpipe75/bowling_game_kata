#!/usr/bin/perl
use strict;
use warnings;

# コマンドライン引数のチェック
if (@ARGV != 1) {
    die "Usage: $0 filename\n";
}

my $filename = $ARGV[0];

# ファイルを開く
open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

# ファイルを一行ずつ読み取り、数値を二倍して標準出力に書き出す
while (my $line = <$fh>) {
    chomp $line;  # 行末の改行を取り除く
    if ($line =~ /^-?\d+(\.\d+)?$/) {  # 数値であるかをチェック
        my $doubled = $line * 2;
        print "$doubled\n";
    } else {
        warn "Non-numeric line encountered: $line\n";
    }
}

# ファイルを閉じる
close($fh);
