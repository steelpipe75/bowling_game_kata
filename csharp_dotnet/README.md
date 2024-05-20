# bowling_game_kata : csharp_dotnet

C# + .NET CLI(dotnetコマンド) で ボーリングのスコア計算

----

## ソリューションの立ち上げ

### ソリューションの作成
``` Powershell
mkdir BowlingGameSolution
cd .\BowlingGameSolution\
dotnet new sln -n BowlingGameSolution
```

### .gitignoreの作成
``` Powershell
dotnet new gitignore
```

### ライブラリプロジェクトの作成
``` Powershell
dotnet new classlib -n BowlingGameLib
dotnet sln add BowlingGameLib/BowlingGameLib.csproj
```

### ライブラリのテストプロジェクトの作成
``` Powershell
dotnet new xunit -n BowlingGameLib.Tests
dotnet sln add BowlingGameLib.Tests/BowlingGameLib.Tests.csproj
dotnet add BowlingGameLib.Tests/BowlingGameLib.Tests.csproj reference BowlingGameLib/BowlingGameLib.csproj
```

### CLIツールプロジェクトの作成
``` Powershell
dotnet new console -n BowlingGameCli
dotnet sln add BowlingGameCli/BowlingGameCli.csproj
dotnet add BowlingGameCli/BowlingGameCli.csproj reference BowlingGameLib/BowlingGameLib.csproj
```

----

## ビルド
```
dotnet build
```

## テスト
```
dotnet test
```

## 実行
```
dotnet run --project .\BowlingGameCli\BowlingGameCli.csproj
```

