class Account::GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.partpost_groups.recent
  end
end
