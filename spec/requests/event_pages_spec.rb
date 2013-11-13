require 'spec_helper'

describe "Event pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user } 

  describe "event creation" do
    before { visit new_event_path }

    describe "with invalid information" do

      before { click_button "Create event" }

      it "should reload event new page" do
        expect(page).to have_content("New Event")
      end

      describe "error messages" do
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { create_event }

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

  describe "event show page" do

    describe "as incorrect user" do
      let(:other_user) { FactoryGirl.create(:user) }
      let(:other_event) { FactoryGirl.create(:event, user: other_user) }
      before { visit event_path(other_event) }

      it { should_not have_link("edit") }
      it { should_not have_link("delete") }
      it { should have_content("join us!") }
    end
    
    describe "as correct user" do
      before do
        visit new_event_path
        create_event
      end

      it { should have_link("edit") }
      it { should have_link("delete") }
      it { should have_content("join us!") }
    end
  end

  describe "event updating" do
    before do
      visit new_event_path
      create_event
      click_link "edit"
    end

    describe "edit event page" do
      it { should have_content("Update your event") }
      it { should have_button("Save changes") }

      describe "with invalid information" do
        before do
          fill_in "Details", with: " "
          click_button "Save changes"
        end

        it { should have_content('error') }
      end

      describe "with valid information" do
        before do
          fill_in "Details", with: "voluptas sed fugiat"
          click_button "Save changes"
        end

        it { should have_content("Event updated") }
        it { should have_content("voluptas sed fugiat") }
      end
    end
  end
end