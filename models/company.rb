class Company < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :jobs
  def to_api
    {
      id: id,
      name: name,
      location: location,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end