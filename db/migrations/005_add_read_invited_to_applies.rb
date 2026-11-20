Sequel.migration do
  change do
    alter_table(:applies) do
      add_column :read,    TrueClass, default: false
      add_column :invited, TrueClass, default: false
    end
  end
end