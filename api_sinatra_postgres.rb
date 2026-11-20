# api_sinatra_postgres.rb
require 'sequel'
require 'sequel/extensions/seed'
require 'pg'
require 'json'
require 'multi_json'
require 'sinatra'
require 'sinatra/namespace'

# Подключение к БД
require_relative 'config/database'

# Единый Content-Type для всех ответов Postman
before do
  content_type 'application/json'
end

# Хелпер для массива моделей: вызывает to_api у каждой и пакует в JSON
def collection_to_api(collection)
  MultiJson.dump(collection.map { |s| s.to_api })
end

# Корневой маршрут
get '/' do
  # system 'rake --tasks'
  "Hi! I am api_sinatra_postgres!\n\n"
end

# Автозагрузка всех .rb-файлов из каталогов
%w{ models controllers routes }.each { |dir| Dir.glob("./#{dir}/*.rb").sort.each { |file| require file } }