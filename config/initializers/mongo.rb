MongoMapper.connection = Mongo::Connection.new('localhost', 27017, :logger => Rails.logger)
MongoMapper.database = "badge-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
