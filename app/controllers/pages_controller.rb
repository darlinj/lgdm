class PagesController < ApplicationController
  skip_before_filter :authenticate, :only => [:home]

  def home
  end

end
