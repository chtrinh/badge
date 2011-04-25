require "mongo_session_store/mongo_mapper"

Badge::Application.config.session_store = :mongo_mapper_store
