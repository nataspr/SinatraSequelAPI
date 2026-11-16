class Job < Sequel::Model
  plugin :timestamps, update_on_create: true
  
  many_to_one :company
  one_to_many :applies

  def to_api
    {
      id: id,
      name: name,
      place: place,
      company_id: company_id,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end