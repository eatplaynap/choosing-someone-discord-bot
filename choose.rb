# frozen_string_literal: true

bot = Discordrb::Commands::CommandBot.new token: "#{ENV['TOKEN']}", prefix: '!'

bot.command(:you) do |event|
  channel = event.user.voice_channel
  if channel.nil?
    event.send_message "ボイスチャンネルに入ってからコマンドを実行してください"
  else
    event.send_message "#{channel.name}"
  end
end

bot.run
