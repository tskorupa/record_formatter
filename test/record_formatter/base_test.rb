require 'test_helper'
require 'record_formatter/base'

class RecordFormatterBaseTest < ActiveSupport::TestCase

  test "deployable_records with defaults" do
    klass = dummy_class
    klass.expects( RecordFormatter::Base::DEFAULT_SCOPE ).once
    klass.expects(:select).with( all_of([]) ).once.returns(klass)

    formatter = RecordFormatter::Base.new klass
    formatter.deployable_records
  end

  test "deployable_records with plucked columns" do
    klass = dummy_class
    klass.expects( RecordFormatter::Base::DEFAULT_SCOPE ).once
    klass.expects(:select).with( all_of(["id AS id"]) ).once.returns(klass)
    formatter = RecordFormatter::Base.new klass

    formatter.columns :id
    formatter.deployable_records
  end

  test "deployable_records with aliased columns" do
    klass = dummy_class
    klass.expects( RecordFormatter::Base::DEFAULT_SCOPE ).once
    klass.expects(:select).with( all_of(["id AS foo"]) ).once.returns(klass)
    formatter = RecordFormatter::Base.new klass

    formatter.columns :id, alias: :foo
    formatter.deployable_records
  end

  test "deployable_records with custom scope" do
    klass = dummy_class
    klass.expects(:foo).once
    klass.expects(:select).with( all_of([]) ).once.returns(klass)

    formatter = RecordFormatter::Base.new klass, scope: :foo
    formatter.deployable_records
  end

  private

  def dummy_class
    Class.new(ActiveRecord::Base) do
      def self.name
        "Dummy"
      end
    end
  end

end
