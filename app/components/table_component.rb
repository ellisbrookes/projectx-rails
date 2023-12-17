class TableComponent < ViewComponent::Base
  def initialize(headers:, rows:)
    super

    @headers = headers
    @rows = rows
  end
end
