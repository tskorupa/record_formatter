require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/array/extract_options'

module RecordFormatter
  class Base
    DEFAULT_SCOPE = :all
    VALID_OPTIONS = %i(scope)

    def initialize klass, options = {}
      @klass = klass
      @models = {}
      @options = options.slice!(VALID_OPTIONS)
    end

    def columns *attributes
      defaults = attributes.extract_options!

      attributes.each do |name|
        model.add_column name, defaults
      end
    end

    def format_records
      @klass.select(columns_for_select).send(defined_scope)
    end

    private

    def columns_for_select
      model.columns.collect(&:for_select)
    end

    def defined_scope
      @options[:scope] || DEFAULT_SCOPE
    end

    def model
      @models[@klass.to_s.to_sym] ||= RecordFormatter::Model.new
    end
  end
end
