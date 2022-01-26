# 42_pipex
bashのパイプ『 | 』をC言語で実装しました。  
MAC_OSにおいては、エラーメッセージも再現してあります(多分)。
  
## インストール
```
git clone git@github.com:JimpeiYamamoto/42_pipex.git
```
## コンパイル
```
make
```
## 使用方法
```
./pipex infile cmd1 cmd2 outfile
```
- pipex : 実行ファイル名
- infile : cmd1の標準入力へ渡すファイル名
- cmd1 : infileを受け取って実行するコマンド名
- cmd2 : cmd1の出力を受け取って実行するコマンド名
- outfile: cmd2の出力を受け取るファイル名
### 例
以下の二つは同じ動作です。
```
./pipex infile "cat -e" "wc -l" outfile
```
```
< infile cat -e | wc -l > outfile
```
#### 絶対パスで指定しても正常に動作します。
```
./pipex infile "/bin/cat -e" "/bin/wc -l" outfile
```
## テスト (Goの実行環境)
```
make 
make test
```
### テストには以下の内容が網羅的に含まれています
- pipe関数で作られるパイプの容量を超えるinfile
- unset PATH 後の挙動
- infileが存在しない or 権限がない
- cmd1, cmd2 がない
- cmd1, cmd2 を絶対パスで指定
- outfileの権限がない

## キーワード
- ファイルディスクリプタ
- プロセス
- execve, pipe, dup2, fork, wait
- 環境変数PATH