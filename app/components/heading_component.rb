# frozen_string_literal: true

class HeadingComponent < ViewComponent::Base
  def initialize(title:, text:, link_title:, link_path:)
    @title = title
    @text = text
    @link_title = link_title
    @link_path = link_path
  end

end
