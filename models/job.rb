class Job < Sequel::Model
  many_to_one :company
  one_to_many :applies
end