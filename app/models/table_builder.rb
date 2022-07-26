require 'action_view'

class TableBuilder
  include ActionView::Helpers::TagHelper

  def initialize(relation)
    @relation = relation
  end

  def list_rows
    relation.list_columns
  end

  def trs
    safe_join(list_rows.map { |row| content_tag(:tr, safe_join(row.map(&:td))) })
  end

  def tbody
    content_tag(:tbody, trs)
  end

  def headers
    list_rows&.first&.map(&:header)
  end

  # def ths
  #   safe_join(header_content.map { |header| content_tag(:th, header) })
  # end

  def header_tr

    content_tag(:tr, ths)
  end

  def thead
    content_tag(:thead, header_tr)
  end

  private

  attr_reader :relation

end
