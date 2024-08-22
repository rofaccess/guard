class Day < ApplicationRecord
  default_scope { order(order: :asc) }
end
