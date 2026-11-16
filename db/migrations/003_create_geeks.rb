Sequel.migration do
  change do
    create_table!(:geeks, ignore_index_errors: true) do # сначала удаление таблицы, если она существует
      primary_key :id
      String :name, text: true, null: false
      String :stack, text: true, null: false
      TrueClass :resume, default: false # тип колонки boolean
      DateTime :created_at
      DateTime :updated_at
      index :id # дополнительный индекс на id
    end
  end
end