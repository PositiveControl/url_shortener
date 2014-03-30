require 'spec_helper'
require 'capybara/rspec'
require_relative '../app'

Capybara.app = App

feature 'finding the homepage' do

  scenario 'homepage has a form' do
    visit ('/')
    expect(find_field('url_entry').value).to eq 'Enter the URL you would like to "shorten"'
    fill_in "url_entry", :with => "http://www.whitehouse.com"
    click_on "Shorten"
  end

  scenario 'user submits url and is returned a shortened version' do
    visit ('/')
    fill_in "url_entry", :with => "http://www.whitehouse.com"
    click_on "Shorten"
    expect(page).to have_content "Original URL"
    expect(page).to have_content '"Shortened" URL'
    expect(page).to have_content "http://www.whitehouse.com"
    expect(page).to have_content "http://ur-ly.herokuapp.com/1"
  end
end
