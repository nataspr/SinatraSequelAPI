namespace '/api/v1' do

  # GET /api/v1/applies_read — только прочитанные отклики
  get '/applies_read' do
    collection_to_api(Apply.read.all)
    # Apply.read возвращает dataset (не массив) а all выполняет запрос и возвращает массив
  end

  # GET /api/v1/applies_unread — только непрочитанные
  get '/applies_unread' do
    collection_to_api(Apply.unread.all)
  end
end