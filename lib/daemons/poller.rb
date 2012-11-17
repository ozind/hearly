#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

$running = true
Signal.trap("TERM") do 
  $running = false
end

#while($running) do
  EventMachine.run do
    connection = AMQP.connect(ENV['AMQP_URL'])
    channel = AMQP::Channel.new(connection)
    exchange = channel.fanout("amq.fanout")
    queue = channel.queue("create.user")
    queue.bind(exchange)
    queue.subscribe do |payload|
      user_details = JSON.parse(payload)
      User.create!(user_details)
      puts "***********************************"
      #connection.close {
      #   EventMachine.stop { exit }
      #}
    end
  end
#end