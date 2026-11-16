namespace '/api/v1' do
  # GET /api/v1/companies — список всех компаний
  get '/companies' do
    collection_to_api(Company.all)
  end

  # GET /api/v1/companies/:id — одна компания
  get '/companies/:id' do
    company = Company[params[:id].to_i]
    halt 404, { error: 'Company not found' }.to_json unless company
    company.to_api.to_json
  end
end