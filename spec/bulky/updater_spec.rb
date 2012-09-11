require 'spec_helper'

describe Bulky::Updater do

  it "has bulky_updates as it's QUEUE" do
    Bulky::Updater::QUEUE.should eq(:bulky_updates)
  end

  it "uses the QUEUE constant to set the :@queue class instance variable" do
    Bulky::Updater.instance_variable_get(:@queue).should eq(Bulky::Updater::QUEUE)
  end

  describe ".perform" do 
    before :each do
      Account.stub(:find).and_return(@account = Account.new)
      @account.stub!(:update_attributes!).and_return(true)
    end

    it "will find the class it is supposed to update" do
      klass = "Account"
      klass.should_receive(:constantize).and_return(Account)
      Bulky::Updater.perform(klass, 1, {"name" => "Adam"})
    end

    it "will find the instance from the given class and id" do
      Account.should_receive(:find).with(1).and_return(@account)
      Bulky::Updater.perform('Account', 1, {"name" => "Adam"})
    end

    it "will update the attributes on the instance with the given updates" do
      @account.should_receive(:update_attributes!).with(updates = {"company" => "Adam Inc"})
      Bulky::Updater.perform('Account', 1, updates)
    end
  end

end
