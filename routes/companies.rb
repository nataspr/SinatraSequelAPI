namespace '/api/v1' do
  # GET /api/v1/companies — список всех компаний
  get '/companies' do
    #collection_to_api(Company.all)
    ds = Company.dataset

    ds = ds.by_name(params['name'])if params['name']
    ds = ds.by_location(params['location']) if params['location']
    collection_to_api(ds.all)
  end

  # GET /api/v1/companies/:id — одна компания
  get '/companies/:id' do
    company = Company[params[:id].to_i] # .to_i делает число
    if company
      # Компания найдена
      company.to_api.to_json
    else
      # Компания не найдена — статус 404 и JSON с ошибкой
      status 404
      { error: 'Company not found' }.to_json
    end
  end
    # POST /api/v1/companies — создание новой компании
  post '/companies' do
    begin
      # JSON из тела запроса
      data = MultiJson.load(request.body.read)
      
      company = Company.create(
        name: data['name'],
        location: data['location']
      )
      status 201
      company.to_api.to_json
    rescue => e
      status 400
      { error: 'Invalid data', details: e.message }.to_json
    end
  end
# GET /api/v1/company_jobs?name=Mo — все вакансии компании по её имени
  get '/company_jobs' do
    name = params[:name]
    jobs = Company.company_jobs(name)

    if jobs.empty?
      status 404
      { message: 'Company not found or no jobs', status: 404, name: name }.to_json
    else
      collection_to_api(jobs.all)
    end
  end

    # GET /api/v1/companies/:id/jobs — все вакансии конкретной компании
  get '/companies/:id/jobs' do
    company = Company[params[:id].to_i]
    if company
      collection_to_api(company.jobs)
    else
      status 404
      { error: 'Company not found' }.to_json
    end
  end

end