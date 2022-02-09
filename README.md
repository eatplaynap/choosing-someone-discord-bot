# choosing-someone-discord-bot
choosing-someone-discord-botは、Discordのボイスチャンネルに参加しているメンバーをランダムに指名するbotです。

## 開発環境
Ruby 3.0.1

## 機能概要
- Discordの音声チャンネルに参加し、任意のテキストチャットで`!you`コマンドを実行すると、ボイスチャンネルに参加中のメンバー1人のユーザー名がランダムにテキストチャットに出力されます。
- 音声ミュート状態のメンバーは指名対象外になります。
- `!you 4`のように引数を渡すと、引数分のユーザーが指名できます。

## 動作イメージ
![Gif](https://raw.github.com/wiki/eatplaynap/choosing-someone-discord-bot/wanted.gif)

## 利用方法
利用方法は2つあります。お好みの方法を選択ください。
### 下記招待URLから追加
https://discord.com/oauth2/authorize?client_id=871997264518856714&permissions=33557504&scope=bot

### 自分でDiscordのApplicationの作成
https://discordapp.com/developers/applications/
- Developer PortalからBotを作成し、発行されたTokenをコードの環境変数に設定
- PRESENCE INTENT、SERVER MEMBERS INTENTを有効にする
- OAuth2 の Scope から Bot をチェックし、下記必要権限にチェックする
  - View Channels
  - Send Messages
  - Use Voice Activity
- 発行されたURLからBotをサーバーに招待する

## 起動方法
### ローカルの場合
`ruby choose.rb`でBotを起動させることができます。

### Herokuを利用する場合
デプロイ後、ResourcesタブよりDynoの`bundle exec ruby choose.rb`が有効になっていることを確認してください。
