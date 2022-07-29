# frozen_string_literal: true

module Admin
  class TagsController < ApplicationController
    def create
      tag = Tag.new(tag_params)
      if tag.valid?
        tag.save
        render json: {
          id: tag.id,
          name: tag.name,
          text_color: tag.text_color,
          background_color: tag.background_color
        }.to_json
      end
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end
  end
end
