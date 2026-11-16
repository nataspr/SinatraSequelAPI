namespace '/api/v1' do
  # GET /api/v1/jobs — список всех вакансий
  get '/jobs' do
    collection_to_api(Job.all)
  end

  # GET /api/v1/jobs/:id — одна вакансия или 404
  get '/jobs/:id' do
    job = Job[params[:id].to_i]
    if job
      job.to_api.to_json
    else
      status 404
      { error: 'Job not found' }.to_json
    end
  end
end