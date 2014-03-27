require 'spec_helper'
require 'capybara/rspec'
require_relative '../app'

Capybara.app = App

feature 'finding the homepage' do

  scenario 'homepage has a form' do
    visit ('/')

    expect(page).to have_content("Enter URL to be shortened")
    fill_in "url_entry", :with => "http://www.whitehouse.com"
  end
end