# frozen_string_literal: true

class CharacterFansController < ApplicationController
  before_action :load_i18n, only: %i(index)

  def index(character_id)
    @character = Character.published.find(character_id)
    @favorite_characters = @character.
      favorite_characters.
      order(id: :desc)
  end

  private

  def load_i18n
    keys = {
      "verb.follow": nil,
      "noun.following": nil,
      "messages.components.favorite_button.add_to_favorites": nil,
      "messages.components.favorite_button.added_to_favorites": nil
    }

    load_i18n_into_gon keys
  end
end
