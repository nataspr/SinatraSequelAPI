require 'rake'
require 'dotenv/tasks'
require 'sequel'
require 'dotenv/load'

namespace :db do
  require 'sequel'                 # ORM
  Sequel.extension :migration      # включает Sequel::Migrator — без этого :migration не работает

  environment = ENV['RACK_ENV'] || 'development'
  ENV['DATABASE'] = 'sinatra_seq_dev'  if environment == 'development'
  ENV['DATABASE'] = 'sinatra_seq_test' if environment == 'test'
  ENV['DATABASE'] = 'sinatra_seq_prod' if environment == 'production'

  # Каталог с файлами миграций (001_*.rb, )
  migrations_directory = 'db/migrations'
  # Строка подключения к PostgreSQL
  connection_string = ENV['DATABASE_URL']

  # к какой базе реально подключаемся
  puts "ENV['DATABASE'] = #{ENV['DATABASE'].inspect}"
  puts "connection_string = #{connection_string.inspect}"

  DB = Sequel.connect(connection_string)
  db=DB
  # db:version — текущая версия схемы
  desc 'Prints current schema version'
  task :version do
    # какие переменные/окружения реально загружены
    puts "Sinatra::Application.settings = #{Sinatra::Application.settings.inspect}"
    puts "Sinatra::Application.environment = #{Sinatra::Application.environment.inspect}"
    puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV'].inspect}"
    puts "environment = #{environment.inspect}"
    puts "ENV['DATABASE_URL'] = #{ENV['DATABASE_URL'].inspect}"
    puts "db[:schema_info].first = #{db[:schema_info].first.inspect}"

    # schema_info — служебная таблица Sequel: одна строка с номером последней миграции
    version = if db.tables.include?(:schema_info)
                db[:schema_info].first[:version]
              end || 0
    puts "Schema Version: #{version}"
  end

  # db:migrate — применить миграции
  # зависимость :dotenv — сначала загрузить .env
  # аргумент :version — необязательный, `rake db:migrate[3]`
  desc 'Run migrations up to specified version or to latest.'
  task :migrate, [:version] => [:dotenv] do |_, args|
    version = args[:version]

    raise 'Missing Connection string' if connection_string.nil?

    message = if version.nil?
                # Без target —  всё до последней
                Sequel::Migrator.run(db, migrations_directory)
                'Migrated to latest'
              else
                # С target до указанной версии
                Sequel::Migrator.run(db, migrations_directory, target: version.to_i)
                "Migrated to version #{version}"
              end

    puts message if environment != 'test'
  end

  # db:rollback — откатить миграции
  # аргумент :target — до какой версии откатывать
  desc 'Perform rollback to specified target or full rollback as default'
  task :rollback, :target do |t, args|
    args.with_defaults(:target => 0)  # по умолчанию до 0
    Sequel::Migrator.run(db, migrations_directory, :target => args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  # db:reset — полный откат + накат заново
  # уничтожает все данные в таблицах, созданных миграциями
  desc 'Perform migration reset (full rollback and migration)'
  task :reset do
    Sequel::Migrator.run(db, migrations_directory, :target => 0)  # откат до 0
    Sequel::Migrator.run(db, migrations_directory)                # накат до latest
    Rake::Task['db:version'].execute                              # печать
  end

  # для работы с SEED
  desc 'Load seed data from ./seeds'
  task :seed do
    require 'sequel/extensions/seed'
    # Очистить schema_seeds, чтобы сиды применились повторно
    # sequel-seed создаёт эту таблицу при первом запуске и пишет туда имена применённых файлов
    if db.tables.include?(:schema_seeds)
      db[:schema_seeds].delete #необходимо очищать содержание средствами IDE перед каждым запуском
      puts 'schema_seeds cleared'
    end

    Sequel::Seed.setup(ENV['RACK_ENV'] || :development)

    Sequel.extension :seed
    # Применить все файлы из seeds
    Sequel::Seeder.apply(db, './seeds')
    puts 'Seeds applied'
  end
end