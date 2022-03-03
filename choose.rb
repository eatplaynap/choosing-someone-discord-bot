# frozen_string_literal: true

require 'dotenv/load'
require 'discordrb'

bot = Discordrb::Commands::CommandBot.new(
  token: (ENV['TOKEN']).to_s,
  prefix: '!'
)

bot.command(:you) do |event, number|
  channel = event.user.voice_channel
  return event.send_message('Join a voice channel before executing the command!') if channel.nil?
  return event.send_message("Huh, seems like you're all muted!") if channel.users.all?(&:self_muted?)

  number = number&.to_i || 1
  return event.send_message('The number should be greater than 0!') unless number.positive?

  unmuted_users = channel.users.reject(&:self_muted?)
  user_names = unmuted_users.map(&:name)
  chosen_users = user_names.sample(number)

  event.send_message chosen_users.join(', ')
end

bot.run
