class Job < Sequel::Model
  plugin :timestamps, update_on_create: true
  
  many_to_one :company
  one_to_many :applies

  dataset_module do
    def by_place(place)
      return self if place.nil? || place.empty?
      where(place: /#{place}/i)
    end

    def by_name(name)
      return self if name.nil? || name.empty?
      where(name: /#{name}/i)
    end
  end

  def self.company_jobs(company_id)
    where(company_id: company_id)
  end

  def to_api
    {
      id: id,
      name: name,
      place: place,
      company_id: company_id
      # created_at: created_at,
      # updated_at: updated_at
    }
  end
end