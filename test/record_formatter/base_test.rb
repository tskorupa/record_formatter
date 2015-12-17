require 'test_helper'
require 'record_formatter/base'

class RecordFormatterBaseTest < ActiveSupport::TestCase
  DummyClass = Class.new(ActiveRecord::Base)

  test 'format records with defaults' do
    should_expect_call_to method: RecordFormatter::Base::DEFAULT_SCOPE
    should_expect_call_to method: :select, args: []
    evaluate_formatter
  end

  test 'format records with plucked columns' do
    should_expect_call_to method: RecordFormatter::Base::DEFAULT_SCOPE
    should_expect_call_to method: :select, args: ['id AS id']
    evaluate_formatter { columns :id }
  end

  test 'format records with aliased columns' do
    should_expect_call_to method: RecordFormatter::Base::DEFAULT_SCOPE
    should_expect_call_to method: :select, args: ['id AS foo']
    evaluate_formatter { columns :id, alias: :foo }
  end

  test 'format records with custom scope' do
    should_expect_call_to method: :foo
    should_expect_call_to method: :select, args: []
    evaluate_formatter args: { scope: :foo }
  end

  private

  def should_expect_call_to klass: DummyClass, method:, args: nil
    expected_args = all_of(args)
    klass.expects(method).with(expected_args).once.returns(klass)
  end

  def evaluate_formatter method: :format_records, args: {}, &block
    formatter = RecordFormatter::Base.new(DummyClass, args)
    formatter.instance_eval(&block) if block
    formatter.send method
  end
end
