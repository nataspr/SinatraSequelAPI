# нужны существующие job_id и geek_id
Sequel.seed(:development, :test) do
  def run
    DB[:applies].insert(job_id: 1, geek_id: 1, read: true,  invited: false)
    DB[:applies].insert(job_id: 2, geek_id: 3, read: false, invited: false)
    DB[:applies].insert(job_id: 1, geek_id: 2, read: true,  invited: true)
    DB[:applies].insert(job_id: 3, geek_id: 1, read: false, invited: false)
    DB[:applies].insert(job_id: 4, geek_id: 2, read: false, invited: false)
    DB[:applies].insert(job_id: 2, geek_id: 4, read: true,  invited: true)
  end
end