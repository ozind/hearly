require 'amqp'

EM.next_tick do
  RABBIT_CON = AMQP.start(ENV['AMQP_URL'])
end