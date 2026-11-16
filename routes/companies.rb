namespace '/api/v1' do
  # GET /api/v1/companies — список всех компаний
  get '/companies' do
    collection_to_api(Company.all)
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
end