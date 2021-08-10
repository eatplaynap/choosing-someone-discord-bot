# frozen_string_literal: true

require 'dotenv/load'
require 'discordrb'

bot = Discordrb::Commands::CommandBot.new token: (ENV['TOKEN']).to_s, prefix: '!'

bot.command(:you) do |event, number|
  channel = event.user.voice_channel
  if channel.nil?
    event.send_message 'ボイスチャンネルに入ってからコマンドを実行してください'
  elsif channel.users.all?(&:self_muted?)
    event.send_message 'ミュートを解除してください'
  else
    number　= number&.to_i || 1
    unmuted_users = channel.users.reject(&:self_muted?)
    user_names = unmuted_users&.map(&:name)
    chosen_users = user_names.sample.(number)
    event.send_message chosen_users
  end
end

bot.run
