require 'mongo'

module Chatterbox
  module Model
    def self.all
      require 'chatterbox/server/app/models/user'
      [User]
    end

    def self.db_name
      if ENV['Chatterbox']
        db_names[ENV['Chatterbox'].to_sym]
      else
        db_names[:dev]
      end
    end

    def self.testing_db
      Mongo::Connection.new.db(db_names[:test])
    end

    def self.development_db
      Mongo::Connection.new.db(db_names[:dev])
    end

    def self.production_db
      Mongo::Connection.new.db(db_names[:prod])
    end

    private
    def self.db_names
      {
        test: 'ChatterboxTesting',
        prod: 'ChatterboxProduction',
        dev: 'ChatterboxDevelopment'
      }
    end
  end
end
