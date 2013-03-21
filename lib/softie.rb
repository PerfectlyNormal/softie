require "softie/version"

module Softie
  extend ActiveSupport::Concern

  module ClassMethods
    def softie(options = {})
      class_attribute :softie_options

      self.softie_options = {
        key: :deleted_at,
        scope: :active,
        deleted_by_class: nil,
        deleted_by_key: :deleted_by
      }.merge(options)

      key softie_options[:key], Time

      if softie_options[:deleted_by_class]
        key softie_options[:deleted_by_key],
            softie_options[:deleted_by_class]
      end

      scope softie_options[:scope], lambda {
        where(softie_options[:key] => nil)
      } if softie_options[:scope]
    end
  end

  def deleted!(options = {})
    public_send("#{softie_options[:key]}=", Time.now.utc)

    if softie_options[:deleted_by_class]
      public_send("#{softie_options[:deleted_by_key]}=", options.delete(:by))
    end

    save
  end

  def restore!
    public_send("#{softie_options[:key]}=", nil)

    if softie_options[:deleted_by_class]
      public_send("#{softie_options[:deleted_by_key]}=", nil)
    end

    save
  end

  def deleted?
    public_send(softie_options[:key]) != nil
  end
end
