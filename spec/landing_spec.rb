# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
  end

  describe 'As a user' do
    describe "When I visit '/'" do
      it 'Then I expect to see Title of Application' do
        visit '/'

        expect(page).to have_content('Viewing Party Lite')
      end

      it 'I see a button to Create a New User' do
        visit '/'

        expect(page).to have_button('Create New User')
      end

      it 'I see a List of Existing User email links' do
        visit '/'
        #  save_and_open_page

        expect(page).to have_link(@user1.email)
        expect(page).to have_link(@user2.email)
        expect(page).to have_link(@user3.email)
        expect(page).to have_link(@user4.email)
      end
    end

    describe 'When I click an email link' do
      it 'I am directed to that users show page' do
        visit '/'

        click_link(@user1.email)

        expect(current_path).to eq("/users/#{@user1.id}")
      end
    end

    describe 'I see a home link' do
      describe 'When I click this link' do
        it 'I am taken to the landing page' do
          visit '/'

          expect(page).to have_link('Home')

          click_link('Home')

          expect(current_path).to eq('/')
        end
      end
    end
  end
end
