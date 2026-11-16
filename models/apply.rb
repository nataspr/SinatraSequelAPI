class Apply < Sequel::Model
  many_to_one :job
  many_to_one :geek

  def to_api
    {
      id: id,
      job_id: job_id,
      geek_id: geek_id,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end