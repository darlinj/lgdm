When %r/^I go to the list of servers$/ do
  visit(path_to("server list"))
end

Then %r/^I should see that the server has been started$/ do
  fail
end

