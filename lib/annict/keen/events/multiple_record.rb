# frozen_string_literal: true

module Annict
  module Keen
    module Events
      class MultipleRecord < Annict::Keen::Events::Application
        def create
          SendKeenEventJob.perform_later("multiple_records", properties(:create))
        end

        private

        def properties(action)
          {
            action: action.to_s,
            user_id: @user&.encoded_id,
            device: browser.device.mobile? ? "mobile" : "pc",
            client_uuid: @request.cookies["ann_client_uuid"],
            locale: @user&.locale,
            time_zone: @user&.time_zone,
            page_category: @params[:page_category],
            keen: { timestamp: @user&.updated_at&.to_s }
          }
        end
      end
    end
  end
end
