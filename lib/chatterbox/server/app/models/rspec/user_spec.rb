require 'chatterbox/server/app/models/user'

describe Chatterbox::Model::User do
  context "includes MongoDBModel's required class methods" do
    it "implements self.index" do
      Chatterbox::User.respond_to?('index', true).should == true
    end

    it "implements self.drop" do
      Chatterbox::Model::User.respond_to?('drop', true).should == true
    end
  end

  context "provides construction semantics" do
    it "creates uniquely named users" do
      Chatterbox::Model::User.create('Schemer'
    end
  end
end
