require "softie/version"

module Softie
  extend ActiveSupport::Concern

  included do
    key :deleted_at, Time
    scope :active, lambda { where(deleted_at: nil) }
  end
end
