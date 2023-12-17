# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  def initialize(title:, path:)
    super

    @title = title
    @path = path
  end
end
