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
      @record_formatter ||= RecordFormatter::Base.new(self, options)
      @record_formatter.instance_eval(&block) if block
      @record_formatter

      extend RecordFormatter::LocalClassMethods
    end

  end

  module LocalClassMethods
    def format_records
      @record_formatter.format_records
    end
  end

end

ActiveRecord::Base.send :include, RecordFormatter
