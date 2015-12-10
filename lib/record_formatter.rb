require 'active_support/concern'
require 'record_formatter/base'
require 'record_formatter/model'
require 'record_formatter/column'

module RecordFormatter
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods

    def acts_as_record_formatter options={}, &block
      custom_method_name = options[:custom_method_name] || :format_records

      @record_formatter ||= RecordFormatter::Base.new(self, options)
      @record_formatter.instance_eval(&block) if block

      instance_eval do
        define_singleton_method( custom_method_name ) do
          @record_formatter.format_records
        end
      end

      @record_formatter
    end

  end

end

ActiveRecord::Base.send :include, RecordFormatter
