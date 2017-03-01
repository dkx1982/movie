class WelcomeController < ApplicationController
  def index
    flash[:alert] = "nidaye"

  end
end
