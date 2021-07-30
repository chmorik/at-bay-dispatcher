Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  get 'ingest' => 'IngestionController#create'
  get 'ingestion_status' => 'IngestionController#status'
end
