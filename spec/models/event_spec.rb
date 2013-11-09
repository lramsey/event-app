require 'spec_helper'

describe Event do

  let(:user) { FactoryGirl.create(:user) }
  before { @event = user.events.build(details: "movie marathon!", start: Time.now + 6.days,
                                      finish: Time.now + 7.days, where: "my house") }

  subject { @event }

  it { should respond_to(:details) }
  it { should respond_to(:start) }
  it { should respond_to(:finish) }
  it { should respond_to(:where) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @event.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank details" do
    before { @event.details = " " }
    it { should_not be_valid }
  end

  describe "with details that are too long" do
    before { @event.details = "a" * 141 }
    it { should_not be_valid }
  end
end