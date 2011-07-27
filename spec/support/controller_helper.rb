def stub_logged_in
  controller.stub(:authenticate).and_return(true)
end
