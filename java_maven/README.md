# bowling_game_kata : java_maven

Java(Maven) で ボーリングのスコア計算

## コンパイル/実行

```
cd .\BowlingGameKata\
mvn compile
java -cp target/classes steelpipe.App ../../testdata/all_ones.txt 
```

## jarのビルド/実行

```
cd .\BowlingGameKata\
mvn package
java -cp target/BowlingGameKata-1.0-SNAPSHOT.jar steelpipe.App ../../testdata/all_ones.txt 
```

## テスト実行

```
cd .\BowlingGameKata\
mvn test
```
