require 'spec_helper'
require_relative '../app'

Capybara.app = App

feature 'finding the homepage' do

  scenario 'homepage has a form' do
    visit ('/')

    

  end
end