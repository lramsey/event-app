require 'spec_helper'

describe "Event pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user } 

  describe "event creation" do
    before { visit new_event_path }

    describe "with invalid information" do

      before { click_button "Create event" }

      it "should reaload even new page" do
        expect(page).to have_content("New Event")
      end

      describe "error messages" do
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
        fill_in 'Details', with: "Lorem ipsum"
        fill_in 'Where',   with: "Los Angeles"
        click_button "Create event" 
       end

      it "should create an event" do
        expect(page).to have_content("Event created!")
      end
    end 
  end
  
  describe "event destruction" do
    before { FactoryGirl.create(:event, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete an event" do
        expect { click_link "delete" }.to change(Event, :count).by(-1)
      end
    end
  end
end