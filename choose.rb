# frozen_string_literal: true

require 'dotenv/load'
require 'discordrb'

bot = Discordrb::Commands::CommandBot.new(
  log_mode: :debug,
  token: (ENV['TOKEN']).to_s,
  prefix: '!'
)

bot.command(:you) do |event, number|
  member =
    begin
      response = Discordrb::API::Server.resolve_member(bot.token, bot.server.id, event.author.id)
      Discordrb::Member.new(JSON.parse(response), bot.server, bot)
    rescue Discordrb::Errors::UnknownMember
      nil
    end
  channel =
    begin
      response = Discordrb::API::Channel.resolve(bot.token, member.voice_channel.id) # TODO: member might be nil
      Discordrb::Channel.new(JSON.parse(response), bot)
    rescue Discordrb::Errors::UnknownChannel
      nil
    end
  return event.send_message('ボイスチャンネルに入ってからコマンドを実行してください') if channel.nil?
  return event.send_message('ミュートを解除してください') if channel.users.all?(&:self_muted?)

  number = number&.to_i || 1
  return event.send_message('選択人数は正の整数を入れてください') unless number > 0

  unmuted_users = channel.users.reject(&:self_muted?)
  user_names = unmuted_users.map(&:name)
  chosen_users = user_names.sample(number)

  event.send_message chosen_users.join(", ")
end

bot.run
