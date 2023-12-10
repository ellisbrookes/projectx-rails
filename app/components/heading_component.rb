# frozen_string_literal: true

class HeadingComponent < ViewComponent::Base
  def initialize(title:, text:, link_title: nil, link_path: nil)
    super

    @title = title
    @text = text
    @link_title = link_title
    @link_path = link_path
  end
end
