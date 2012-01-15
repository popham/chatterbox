require 'chatterbox/server/models/user'

describe Chatterbox::User do
  context "includes MongoDBModel's required class methods" do
    it "implements self.index" do
      Chatterbox::User.respond_to?('index', true).should == true
    end

    it "implements self.drop" do
      Chatterbox::User.respond_to?('drop', true).should == true
    end
  end

  context "provides construction semantics" do
    it "creates uniquely named users" do
      Chatterbox::User.create('Schemer'
    end
  end
end
