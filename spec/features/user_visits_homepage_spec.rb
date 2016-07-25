require "rails_helper"

 RSpec.feature "User vists homepage" do 
   scenario "successfully" do 
     visit root_path
     expect(page).to have_content "My banking app"
   end
 end
