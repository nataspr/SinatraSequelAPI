class Geek < Sequel::Model
  plugin :timestamps, update_on_create: true # для работы updated_at
  one_to_many :applies

  def to_api
    {
      id: id,
      name: name,
      stack: stack,
      resume: resume,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end