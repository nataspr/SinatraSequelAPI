# нужны существующие job_id и geek_id
Sequel.seed(:development, :test) do
  def run
    DB[:applies].insert(job_id: 1, geek_id: 1)
    DB[:applies].insert(job_id: 2, geek_id: 2)
    DB[:applies].insert(job_id: 3, geek_id: 3)
    DB[:applies].insert(job_id: 1, geek_id: 4)
  end
end