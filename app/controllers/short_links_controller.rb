class ShortLinksController < ApplicationController
  def create
    short_link = ShortLink.new(short_link_params)

    if short_link.save
      render json: { long_link: short_link.long_link, short_link: shortened_link(short_link) }, status: :created
    else
      render json: short_link.errors, status: :unprocessable_entity
    end
  end

  private

  def short_link_params
    params.permit(:long_link)
  end

  def shortened_link(short_link)
    "#{request.base_url}/#{short_link.encoded_id}"
  end
end
