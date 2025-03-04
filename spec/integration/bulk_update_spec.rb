require 'spec_helper'
require 'rake'

describe "Bulk Updates" do

  let(:accounts) do
    Account.create! business: "TMA"
    Account.create! business: "Adam Incorporated"
    Account.create! business: "Ambers Accounting LLC"
    Account.all
  end

  describe "Bulky.enqueue_update" do
    it "will bulk update all the accounts" do
      Bulky.enqueue_update(Account, accounts.map(&:id), {"contact" => "Awesome-o-tron"})
      perform_enqueued_jobs
      expect(Account.all.map(&:contact).uniq).to eq(['Awesome-o-tron'])
    end
  end

end
