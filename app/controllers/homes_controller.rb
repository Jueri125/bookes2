class HomesController < ApplicationController

 def top
 end

  def about
  end

  def destroy
    flash[:notice] = "Signed out successfully." if signed_out?
    super
  end

end
