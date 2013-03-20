require "softie/version"

module Softie
  extend ActiveSupport::Concern

  module ClassMethods
    def softie(field = :deleted_at, options = {})
      key field, Time

      scope :active, lambda { where(field: nil) }
    end
  end
end
