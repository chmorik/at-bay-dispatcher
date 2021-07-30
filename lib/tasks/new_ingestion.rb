require 'resque'
require 'resque/tasks'

class NewIngestion
  @queue = :new_ingestion

  def self.perform(ingestion_id)
    ingestion = Ingestion.find_by(id: ingestion_id)
    return if ingestion.blank?

    ingestion.update(status: :running)
    sleep 10
    ingestion.update(status: :completed)
  end
end
