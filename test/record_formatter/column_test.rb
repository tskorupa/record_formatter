require 'test_helper'
require 'record_formatter/column'

class RecordFormatterColumnTest < ActiveSupport::TestCase

  test "initialize record-formatter-column" do
    formatter = RecordFormatter::Column.new :foo
    assert_equal "foo AS foo", formatter.for_select
  end

  test "initialize record-formatter-column with alias" do
    formatter = RecordFormatter::Column.new :foo, alias: :bar
    assert_equal "foo AS bar", formatter.for_select
  end

end
