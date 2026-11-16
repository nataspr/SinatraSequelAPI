namespace '/api/v1' do
  # GET /api/v1/geeks — список всех гиков
  get '/geeks' do
    collection_to_api(Geek.all)
  end

  # GET /api/v1/geeks/:id — один гик или 404
  get '/geeks/:id' do
    geek = Geek[params[:id].to_i]
    if geek
      geek.to_api.to_json
    else
      status 404
      { error: 'Geek not found' }.to_json
    end
  end
end