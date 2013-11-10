/require 'spec_helper'

describe "Event pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "event creation" do
    before { visit new_event_path }

    describe "with invalid information" do

      before { visit signup_path }

      let(:submit) { "Create event" }

      describe "with invalid information" do
        it "should not create an event" do
          expect { click_button :submit }.not_to change(Event, :count)
        end

      describe "error messages" do
        before { click_button "Create event" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
        fill_in 'Details', with: "Lorem ipsum"
        fill_in 'Where',   with: "Los Angeles"
       end

      it "should create an event" do
        expect { click_button "Create event" }.not_to change(Event, :count)
      end
    end
  end
end/