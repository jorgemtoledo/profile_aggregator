class ProfilesController < ApplicationController
  before_action :profile, only: [:create, :update]

  def create
    if @profile
      profile = importer.call

      redirect_to root_path(profile),
                  notice: success_message
    else
      profile = importer.call

      redirect_to root_path(profile),
                  notice: success_message
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to root_path, alert: e.record.errors.full_messages.to_sentence
  rescue StandardError => e
    redirect_to root_path, alert: e.message
  end

  def show
    @profile = Profile.includes(:profile_stat).find(params[:id])
  end

  def update
    profile = Profile.find(params[:id])
    
    if profile.update(update_profile_params)
      redirect_to profile_path(profile),
                  notice: "Perfil atualizado com sucesso"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def rescan
    profile = Profile.find(params[:id])

    Github::ProfileImporter.new(
      profile.github_username,
      profile.github_url
    ).call

    redirect_to profile_path(profile),
                notice: "Perfil re-escaneado com sucesso"
  end

  def destroy
    profile = Profile.find(params[:id])
    profile.destroy

    redirect_to root_path, notice: "Perfil removido com sucesso"
  end
  
  private

  def profile
    @profile = Profile.find_by(github_username: profile_params[:github_username])
  end

  def importer
    Github::ProfileImporter.new(
      profile_params[:github_username],
      profile_params[:github_url]
    )
  end

  def success_message
    @profile ? "Perfil reescaneado com sucesso" : "Perfil cadastrado com sucesso"
  end

  def profile_params
    params.require(:profile).permit(:name, :github_username, :github_url)
  end

  def update_profile_params
    params.require(:profile).permit(:name)
  end

end
