# seed для очистки всех таблиц, первый на запуск
Sequel.seed(:development, :test) do
  def run
    puts 'Start truncate for all models'

    # самая зависимая таблица applies,иначе PostgreSQL не даст очистить родителя из-за FK
    DB[:applies].truncate(cascade: true, restart: true) # restart - id опять с 1
    DB[:geeks].truncate(cascade: true, restart: true)
    DB[:jobs].truncate(cascade: true, restart: true)
    DB[:companies].truncate(cascade: true, restart: true)

    puts 'Models truncated'
  end
end