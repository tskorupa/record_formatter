require 'test_helper'
require 'record_formatter/model'

class RecordFormatterModelTest < ActiveSupport::TestCase

  test "initialize record-formatter-model" do
    formatter = RecordFormatter::Model.new
    assert_equal [], formatter.columns
  end

  test "add new column" do
    formatter = RecordFormatter::Model.new
    assert_equal [], formatter.columns
    formatter.stubs(:add_column_internal).once.returns(:foo)
    assert_equal [:foo], formatter.add_column(:foo)
    assert_equal [:foo], formatter.columns
  end

  test "add existing column" do
    formatter = RecordFormatter::Model.new
    assert_equal [], formatter.columns
    formatter.stubs(:add_column_internal).twice.returns(:foo)
    # First insert
    assert_equal [:foo], formatter.add_column(:foo)
    assert_equal [:foo], formatter.columns
    # Second insert
    assert_equal [:foo], formatter.add_column(:foo)
    assert_equal [:foo], formatter.columns
  end

end
