class Company < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :jobs
  def to_api
    {
      id: id,
      name: name,
      location: location
      # created_at: created_at,
      # updated_at: updated_at
    }
  end

  # Возвращает dataset (не массив), можно продолжать цепочку
  def self.by_name(name)
    return where if name.nil? || name.empty? # если name пустой это вернёт все записи, а не пусто
    where(name: /#{name}/i)   # regex case-insensitive: name ~* 'Mo'
  end

  # Такой метод доступен не только как Company.by_location, но и в цепочке Company.where(...).by_location(...)
  dataset_module do
    def by_location(location)
      return self if location.nil? || location.empty?
      where(location: /#{location}/i)
    end
  end

  # Все вакансии компании по её имени
  def self.company_jobs(name)
    company = by_name(name).first
    return Job.where(false) unless company  # пустой dataset, если компании нет
    Job.where(company_id: company.id)
  end

end