class Geek < Sequel::Model
  plugin :timestamps, update_on_create: true # для работы updated_at
  one_to_many :applies
end