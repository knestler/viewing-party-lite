
require 'rails_helper'

RSpec.describe 'Login Page' do
  describe 'As a User' do
    describe 'When I visit the landing page' do
      it 'I see a link to login that takes me to the longin page' do
        visit root_path

        click_on "Login"

        expect(current_path).to eq('/login')
      end
    end

    describe 'when i input credentials into login form' do 
      it "cannot log in with bad credentials" do
        user = User.create(name: 'Kristen', email: "kristen@gmail.com", password: "test", password_confirmation: 'test')
        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: "incorrect password"

        click_on "Log In"

        expect(current_path).to eq(login_path)

        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end

    describe 'When I visit the landing page after loggin in' do
      it 'I see a link to logout that takes me back to the longin page' do
        visit root_path

        click_on "Login"

        expect(current_path).to eq('/login')

        user = User.create(name: 'Kristen', email: "kristen@gmail.com", password: "test", password_confirmation: 'test')
        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: "test"

        click_on "Log In"

        visit root_path

        expect(page).to have_link("Logout")
        expect(page).to_not have_link("Login")



      end
    end

    describe 'when i input credentials into login form' do 
      it "cannot log in with bad credentials" do
        user = User.create(name: 'Kristen', email: "kristen@gmail.com", password: "test", password_confirmation: 'test')
        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: "incorrect password"

        click_on "Log In"

        expect(current_path).to eq(login_path)

        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
