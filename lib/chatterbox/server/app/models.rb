require 'mongo'

module Chatterbox
  module Models
    def self.include
      require 'chatterbox/server/models/user'
    end

    def self.all
      include
      [User]
    end

    def self.db_name
      db = Chatterbox::Models.db_names[:dev]
      env = ENV['Chatterbox'].to_sym if ENV['Chatterbox']
      db = Chatterbox::Models.db_names[env] if env
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
