require 'amqp'

EM.next_tick do
  RABBIT_CON = AMQP.start(ENV['RABBITMQ_BIGWIG_URL'])
end