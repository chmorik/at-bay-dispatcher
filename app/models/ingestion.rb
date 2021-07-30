class Ingestion < ActiveRecord::Base

  enum status: [ :accepted, :running, :error, :complete ]
end
