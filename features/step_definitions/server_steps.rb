When %r/^I go to the list of servers$/ do
  visit(path_to("server list"))
end

Then %r/^I should see that the server has been started$/ do
  within("table") do
    #save_and_open_page
    page.should have_content("pending")
    page.should have_content("pri-22222222")
  end
end
