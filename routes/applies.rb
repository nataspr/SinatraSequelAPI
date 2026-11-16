namespace '/api/v1' do
  # GET /api/v1/applies — список всех откликов
  get '/applies' do
    collection_to_api(Apply.all)
  end

  # GET /api/v1/applies/:id — один отклик или 404
  get '/applies/:id' do
    apply = Apply[params[:id].to_i]
    if apply
      apply.to_api.to_json
    else
      status 404
      { error: 'Apply not found' }.to_json
    end
  end
end