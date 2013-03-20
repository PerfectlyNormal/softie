require "softie/version"

module Softie
  extend ActiveSupport::Concern

  module ClassMethods
    def softie(field = :deleted_at, options = {})
      key field, Time

      scope :active, lambda { where(field: nil) }
    end
  end

  def deleted!(options = {})
    self.deleted_at = Time.now.utc
  end

  def restore!
    self.deleted_at = nil
    save
  end

  def deleted?
    self.deleted_at != nil
  end
end
