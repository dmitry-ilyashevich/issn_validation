require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/models'

class IssnValidationTest < ActiveSupport::TestCase
  test 'issn should match regex' do
    issn = '15905999'
    assert issn.match(ValidationExtensions::IssnValidation::ISSN_REGEX)
  end

  test 'issn should not match regex' do
    issn = 'abc123ab'
    assert !issn.match(ValidationExtensions::IssnValidation::ISSN_REGEX)
  end

  test 'issn with dashes and spaces should match regex' do
    issn = '1590-5999'
    assert issn.match(ValidationExtensions::IssnValidation::ISSN_REGEX)
  end

  test 'issn should match issn without dashes' do
    magazine = Magazine.new
    magazine.issn = '02512645'
    assert magazine.valid?
  end

  test 'issn should match issn with dashes' do
    magazine = Magazine.new
    magazine.issn = '2075-7999'
    assert magazine.valid?
  end

  test 'issn should match issn with X check digit' do
    magazine = Magazine.new
    magazine.issn = '1144-875X'
    assert magazine.valid?
  end

  test 'issn X should be case insensitive' do
    magazine = Magazine.new
    magazine.issn = '1144-875x'
    assert magazine.valid?
  end

  test 'issn should not match invalid issn' do
    magazine = Magazine.new
    magazine.issn = 'invalid'
    assert !magazine.valid?
  end

  test 'has custom error message' do
    magazine = Magazine.new
    magazine.issn = '9781-590A'
    magazine.valid?
    assert_equal 'is too fantastical!', magazine.errors[:issn].first
  end

  test 'blank should not be valid by default' do
    magazine = Magazine13.new
    magazine.issn = ''
    magazine.valid?
    assert_equal 'is not a valid ISSN code', magazine.errors[:issn].first
  end

  test 'should have an option to allow nil' do
    magazine = Magazine13.new
    magazine.issn = nil
    assert magazine.valid?
  end

  test 'should have an option to allow blank' do
    magazine = Magazine10.new
    magazine.issn = ''
    assert magazine.valid?
  end

  test 'should support old syntax' do
    magazine = OldMagazine.new
    magazine.issn = ''
    assert !magazine.valid?
    magazine.issn = '1144-875x'
    assert magazine.valid?
  end
end
