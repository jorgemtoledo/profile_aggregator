class HomeController < ApplicationController
  def index
    @searched = params[:q].present?
    @profile = Profile.new

    if @searched
      @profiles = search_profiles

      if @profiles.empty?
        flash.now[:alert] = "Perfil não encontrado!"
      end
    else
      @profiles = []
    end
  end

  private

  def search_profiles
    Profile
      .left_joins(:profile_stat)
      .where(
        "profiles.name ILIKE :q OR
         profiles.github_username ILIKE :q OR
         profile_stats.organization ILIKE :q OR
         profile_stats.location ILIKE :q",
        q: "%#{params[:q]}%"
      )
  end
end
