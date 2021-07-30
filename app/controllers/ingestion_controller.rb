require 'resque'

class IngestionController < ApplicationController

  def create
    return render json: { error_message: 'invalid params' }, status: 400 if params[:domain].blank?

    ingestion = Ingestion.find_or_create_by(domain: params[:domain])
    if ingestion.blank?
      ingestion.update(uuid: SecureRandom.uuid, status: :accepted)
      Resque.enqueue(NewIngestion, ingestion.id)
    end
    render json: { ingestion_uuid: ingestion.uuid }
  end

  def status
    return render json: { error_message: 'invalid params' }, status: 400 if params[:ingestion_uuid].blank?

    ingestion = Ingestion.find_by(uuid: params[:ingestion_uuid])
    return render json: { ingestion_status: 'not found' } if ingestion.blank?

    render json: { ingestion_status: ingestion.status }
  end
end
