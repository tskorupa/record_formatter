require 'test_helper'
require 'record_formatter'

class RecordFormatterTest < ActiveSupport::TestCase
  DummyClass = Class.new
  DummyClassWithIncludedModule = Class.new(DummyClass) { include RecordFormatter }
  ActiveRecordSubclass = Class.new(ActiveRecord::Base) { self.abstract_class = true }
  ARSublassWithActsAs = Class.new(ActiveRecordSubclass) { acts_as_record_formatter }
  ARSublassWithActsAsAndCustomScope = Class.new(ActiveRecordSubclass) do
    acts_as_record_formatter custom_method_name: :foobarbaz
  end

  test 'dummy class does not define format_records' do
    assert_raises(NoMethodError) do
      DummyClass.format_records
    end
  end

  test 'dummy class + included module does not define format_records' do
    assert_raises(NoMethodError) do
      DummyClassWithIncludedModule.format_records
    end
  end

  test 'dummy class inheriting from ActiveRecord::Base does not define format_records' do
    assert_raises(NoMethodError) do
      ActiveRecordSubclass.format_records
    end
  end

  test "dummy class inheriting from ActiveRecord::Base + acts_as_record_formatter responds to \
      format_records scope" do
    RecordFormatter::Base.any_instance.expects(:format_records).once.returns('result')
    ARSublassWithActsAs.format_records
    assert_kind_of RecordFormatter::Base, ARSublassWithActsAs.acts_as_record_formatter
  end

  test "dummy class inheriting from ActiveRecord::Base + acts_as_record_formatter with custom \
      method name responds to foobarbaz scope" do
    RecordFormatter::Base.any_instance.expects(:format_records).once.returns('result')
    ARSublassWithActsAsAndCustomScope.foobarbaz
    assert_raises(NoMethodError) { ARSublassWithActsAsAndCustomScope.format_records }
    assert_kind_of RecordFormatter::Base, ARSublassWithActsAsAndCustomScope.acts_as_record_formatter
  end
end
