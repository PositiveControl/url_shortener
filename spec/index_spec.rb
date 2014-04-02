require 'spec_helper'
require 'capybara/rspec'
require_relative '../app'

Capybara.app = App

feature 'Shortens a URL' do
  scenario 'homepage has a form and button' do
    visit ('/')
    fill_in "url_entry", :with => "http://www.google.com"
    click_on "Shorten"
  end

  scenario 'user submits url and is returned a shortened version' do
    visit ('/')
    fill_in "url_entry", :with => "http://www.google.com"
    click_on "Shorten"
    expect(page).to have_content "Original URL"
    expect(page).to have_content '"Shortened" URL'
    expect(page).to have_content "http://www.google.com"
    expect(page).to have_content "http://ur-ly.herokuapp.com/2"

    visit '/2'
    current_url.should == "http://www.google.com/"
  end

  scenario 'user inputs non-URL' do
    visit ('/')
    fill_in "url_entry", :with => "www.google.com"
    click_on "Shorten"
    expect(page).to have_content "The text you entered is not a valid URL"
    fill_in "url_entry", :with => "http://www.google.com"
    click_on "Shorten"
    expect(page).to have_content "Original URL"
    visit ('/')
    expect(page).to_not have_content "The text you entered is not a valid URL"
  end
end
