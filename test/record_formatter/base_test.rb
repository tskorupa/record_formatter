require 'test_helper'
require 'record_formatter/base'

class RecordFormatterBaseTest < ActiveSupport::TestCase

  DummyClass = Class.new(ActiveRecord::Base)

  test "format_records with defaults" do
    DummyClass.expects( RecordFormatter::Base::DEFAULT_SCOPE ).once
    DummyClass.expects(:select).with( all_of([]) ).once.returns(DummyClass)

    formatter = RecordFormatter::Base.new DummyClass
    formatter.format_records
  end

  test "format_records with plucked columns" do
    DummyClass.expects( RecordFormatter::Base::DEFAULT_SCOPE ).once
    DummyClass.expects(:select).with( all_of(["id AS id"]) ).once.returns(DummyClass)
    formatter = RecordFormatter::Base.new DummyClass

    formatter.columns :id
    formatter.format_records
  end

  test "format_records with aliased columns" do
    DummyClass.expects( RecordFormatter::Base::DEFAULT_SCOPE ).once
    DummyClass.expects(:select).with( all_of(["id AS foo"]) ).once.returns(DummyClass)
    formatter = RecordFormatter::Base.new DummyClass

    formatter.columns :id, alias: :foo
    formatter.format_records
  end

  test "format_records with custom scope" do
    DummyClass.expects(:foo).once
    DummyClass.expects(:select).with( all_of([]) ).once.returns(DummyClass)

    formatter = RecordFormatter::Base.new DummyClass, scope: :foo
    formatter.format_records
  end

end
