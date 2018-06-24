require 'active_record'

module StringEnum
  extend ActiveSupport::Concern

  module ClassMethods
    # Example using string_enum
    #
    #   class User < ActiveRecord::Base
    #     string_enum :status, %w(active deleted)
    #     string_enum :status, %w(active deleted), prefix: :foo, suffix: :bar, scopes: :plural
    #   end
    #
    #   user = User.new
    #   user.active?
    #   user.deleted?

    def string_enum(field, values, options = {})
      validates field, inclusion: { in: values }

      values.each do |value|
        value = value.to_s if value.is_a? Symbol
        prefix = options[:prefix] == true ? field : options[:prefix]
        postfix = options[:postfix] == true ? field : options[:postfix]
        name = [prefix, value, postfix].compact.join('_')

        scope_name = options[:scopes] == :plural ? name.pluralize : name
        scope scope_name, -> { where(field => value) }
        scope "not_#{scope_name}", -> { where.not(field => value) }

        define_method "#{name}?" do
          send(field) == value
        end
        define_method "#{field}=" do |new_value|
          super(new_value.is_a?(Symbol) ? new_value.to_s : new_value)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, StringEnum)
