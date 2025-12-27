class ShortUrlsController < ApplicationController
  def redirect
    short_url = ShortUrl.find_by!(code: params[:code])
    redirect_to short_url.target_url, allow_other_host: true
  end
end