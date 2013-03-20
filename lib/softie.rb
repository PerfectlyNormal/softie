require "softie/version"

module Softie
  extend ActiveSupport::Concern

  included do
    key :deleted_at, Time
  end
end
