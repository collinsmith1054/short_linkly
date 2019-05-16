class ShortLinksController < ApplicationController
  before_action :set_short_link, only: :show

  def show
    redirect_to @short_link.long_link, status: :moved_permanently
  end

  def create
    short_link = ShortLink.find_or_initialize_by(short_link_params)

    if short_link.persisted? || short_link.save
      render json: { long_link: short_link.long_link, short_link: shortened_link(short_link) }, status: :created
    else
      render json: short_link.errors, status: :unprocessable_entity
    end
  end

  private

  def set_short_link
    @short_link = ShortLink.find_by_encoded_id(params[:id])
    head :not_found unless @short_link
  end

  def short_link_params
    params.permit(:long_link)
  end

  def shortened_link(short_link)
    "#{request.base_url}/#{short_link.encoded_id}"
  end
end
