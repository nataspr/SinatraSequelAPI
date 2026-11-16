# api_sinatra_postgres.rb
require 'sequel'
require 'sequel/extensions/seed'
require 'pg'
require 'json'
require 'multi_json'
require 'sinatra'

# Корневой маршрут
get '/' do
  # system 'rake --tasks'
  "Hi! I am api_sinatra_postgres!\n\n"
end

# Автозагрузка всех .rb-файлов из каталогов
%w{ controllers models routes }.each { |dir| Dir.glob("./#{dir}/*.rb", &method(:require)) }