# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user registration page' do
  describe 'as a user' do
    describe 'when a user visits the /register path' do
      it 'should should see a form to fill out a new user' do
        visit '/register'
        expect(page).to have_link('Home')
        expect(page).to have_content('Viewing Party Lite')
        expect(page).to have_content('Name')
        expect(page).to have_field(:name)
        expect(page).to have_content('Email')
        expect(page).to have_field(:email)
        expect(page).to have_content('Password')
        expect(page).to have_field(:password)
        expect(page).to have_content("Confirm password")
        expect(page).to have_field(:password_confirmation)
        expect(page).to have_button('Create New User')
      end
    end

    describe 'when i fill in form with a valid name, email, and password and click create new user' do
      it 'I am redirected to the user show page' do
        visit '/register'

        fill_in :name, with: 'kristen'
        fill_in :email, with: 'kn@gmail.com'
        fill_in :password, with: 'password123' 
        fill_in :password_confirmation, with: 'password123'

        click_on 'Create New User'

        expect(current_path).to eq("/users/#{User.last.id}")
      end
    end

    describe 'sad path testing' do
      describe 'when I fill in invalid name' do
        it 'I am redirected to the registration page and see error message' do
          visit '/register'

          fill_in :name, with: ''
          fill_in :email, with: 'kn@gmail.com'
          fill_in :password, with: 'password123' 
          fill_in :password_confirmation, with: 'password123' 

          click_on 'Create New User'

          expect(page).to have_content('ERROR: Please enter a valid name')
          expect(current_path).to eq('/register')
        end
      end

      describe 'when I fill in invalid email' do
        it 'I am redirected to the registration page and see error message' do
          visit '/register'

          fill_in :name, with: 'Kristen'
          fill_in :email, with: ''
          fill_in :password, with: 'password123' 
          fill_in :password_confirmation, with: 'password123'

          click_on 'Create New User'

          expect(page).to have_content('ERROR: Please enter a valid email')
          expect(current_path).to eq('/register')
        end
      end

      describe 'when I fill in invalid name and email' do
        it 'I am redirected to the registration page and see error message' do
          visit '/register'

          fill_in :name, with: ''
          fill_in :email, with: ''
          fill_in :password, with: 'password123' 
          fill_in :password_confirmation, with: 'password123'

          click_on 'Create New User'
          expect(page).to have_content('ERROR: Please enter a valid name and email')
          expect(current_path).to eq('/register')
        end
      end

      describe 'when I fill in a non-unique email' do
        it 'I am redirected to the registration page and see error message' do
          user = User.create!(name: 'Eli', email: 'eli@gmail.com', password: 'password123', password_confirmation: 'password123')
          visit '/register'

          fill_in :name, with: 'Eli F'
          fill_in :email, with: 'eli@gmail.com'
          fill_in :password, with: 'password123' 
          fill_in :password_confirmation, with: 'password123'

          click_on 'Create New User'

          expect(page).to have_content('ERROR: Email already in use. Please enter a different email')
          expect(current_path).to eq('/register')
        end
      end
      
      describe 'when I fill in non-unique password' do
        it 'will redirect to register page' do 
        visit '/register'

        fill_in :name, with: 'kristen'
        fill_in :email, with: 'kan@gmail.com'
        fill_in :password, with: 'password123' 
        fill_in :password_confirmation, with: 'password1234'

        click_on 'Create New User'

        expect(page).to have_content('ERROR: Passwords must match')
        expect(current_path).to eq('/register')
        end
      end
    end
  end
end
