module RecordFormatter
  class Model
    attr_accessor :columns

    def initialize
      @columns = []
    end

    def add_column name, options = {}
      @columns.delete(name) if columns.include?(name)
      @columns << add_column_internal(name, options)
    end

    private

    def add_column_internal name, options
      RecordFormatter::Column.new name, options
    end
  end
end
