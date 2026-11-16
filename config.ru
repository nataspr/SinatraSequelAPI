root = File.expand_path File.dirname(__FILE__) # абсолютный путь к папке проекта
require File.join(root, 'api_sinatra_postgres.rb')

run Sinatra::Application