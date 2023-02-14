class DaysController < ApplicationController
  load_and_authorize_resource

  def destroy
    @day.destroy
  end
end
