# frozen_string_literal: true

module Admin
  module DealsHelper
    BADGE_STATUS_COLOR = {
      'lost' => 'red',
      'open' => 'purple',
      'won' => 'green'
    }.freeze

    def deal_list_badge(deal)
      color = BADGE_STATUS_COLOR[Deal.statuses[deal.status]]

      content_tag(:span, deal.status,
                  class: "bg-#{color}-100 text-#{color}-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-#{color}-200 dark:text-#{color}-900")
    end
  end
end
