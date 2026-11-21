namespace '/api/v1' do
  # GET /api/v1/jobs — список всех вакансий
  # get '/jobs' do
  #   collection_to_api(Job.all)
  # end
  # GET /api/v1/jobs — все
  # GET /api/v1/jobs?place=Remo — по place (частичное, case-insensitive)
  # GET /api/v1/jobs?name=Ruby — по name
  # GET /api/v1/jobs?place=Remo&name=Sinatra — оба (AND)
  get '/jobs' do
    ds = Job.dataset

    ds = ds.by_place(params['place']) if params['place']
    ds = ds.by_name(params['name'])   if params['name']

    collection_to_api(ds.all)
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

  # GET /api/v1/jobs_company/MoGo — вакансии компании по точному имени
  get '/jobs_company/:name' do
    company = Company.where(name: params[:name]).first

    if company.nil?
      status 404
      { message: 'Company Document Not Found', status: 404, name: params[:name] }.to_json
    else
      jobs = Job.where(company_id: company.id)
      collection_to_api(jobs.all)
    end
  end

  # GET /api/v1/job/:id — одна вакансия через values
  get '/job/:id' do
    job = Job.where(id: params[:id]).first

    if job
      job.values.to_json   # хэш всех колонок, не через to_api
    else
      status 404
      { message: 'Document Not Found', status: 404, params_id: params[:id] }.to_json
    end
  end
end