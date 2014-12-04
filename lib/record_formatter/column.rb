require 'active_support/core_ext/hash/slice'

module RecordFormatter
  class Column

    VALID_OPTIONS = %i(alias)

    attr_reader :name, :options

    def initialize name, options={}
      @name = name
      @options = options.slice!(VALID_OPTIONS)
    end

    def for_select
      "#{name} AS #{name_alias}"
    end

    private

    def name_alias
      return options[:alias] if options.key? :alias
      name
    end

  end
end
