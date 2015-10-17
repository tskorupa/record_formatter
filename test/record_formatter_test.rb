require 'test_helper'
require 'record_formatter'

class RecordFormatterTest < ActiveSupport::TestCase

  test "dummy class does not define format_records" do
    assert_raises(NoMethodError) do
      dummy_class.format_records
    end
  end

  test "dummy class + included module does not define format_records" do
    assert_raises(NoMethodError) do
      dummy_class_with_included_module.format_records
    end
  end

  test "dummy class inheriting from ActiveRecord::Base does not define format_records" do
    assert_raises(NoMethodError) do
      dummy_class_inheriting_active_record.format_records
    end
  end

  test "dummy class inheriting from ActiveRecord::Base + acts_as_record_formatter responds to format_records scope" do
    RecordFormatter::Base.any_instance.expects(:format_records).once.returns('result')
    dummy_class_with_acts_as.format_records
  end

  private

  def dummy_class
    Class.new do
      def self.name
        "Dummy"
      end
    end
  end

  def dummy_class_with_included_module
    Class.new do
      include RecordFormatter
      def self.name
        "DummyWithModule"
      end
    end
  end

  def dummy_class_inheriting_active_record
    Class.new(ActiveRecord::Base) do
      self.abstract_class = true
      def self.name
        "DummyAR"
      end
    end
  end

  def dummy_class_with_acts_as
    Class.new(ActiveRecord::Base) do
      self.abstract_class = true
      acts_as_record_formatter
      def self.name
        "DummyActsAs"
      end
    end
  end

end
