require 'issn_validation/version'

# The base module that gets included in ActiveRecord::Base.
# Validates whether the value of the specified attribute is a proper ISSN number.
#
#   class Magazine < ActiveRecord::Base
#     validates :issn, issn_format: true
#   end
#
# Configuration options:
# * <tt>:message</tt> - A custom error message (default is: "is not a valid ISSN")
# * <tt>:allow_nil</tt> - If set to true, skips this validation if the attribute is +nil+ (default is +false+).
# * <tt>:allow_blank</tt> - If set to true, skips this validation if the attribute is blank (default is +false+).
# * <tt>:on</tt> - Specifies when this validation is active (default is <tt>:save</tt>, other options <tt>:create</tt>, <tt>:update</tt>).
# * <tt>:if</tt> - Specifies a method, proc or string to call to determine if the validation should
#   occur (e.g. <tt>:if => :allow_validation</tt>, or <tt>:if => Proc.new { |user| user.signup_step > 2 }</tt>).  The
#   method, proc or string should return or evaluate to a true or false value.
# * <tt>:unless</tt> - Specifies a method, proc or string to call to determine if the validation should
#   not occur (e.g. <tt>:unless => :skip_validation</tt>, or <tt>:unless => Proc.new { |user| user.signup_step <= 2 }</tt>).  The
#   method, proc or string should return or evaluate to a true or false value.
module ValidationExtensions
  module IssnValidation
    ISSN_REGEX = /^(?:\d[\ |-]?){7}[\d|X|x]$/

    class IssnFormatValidator < ActiveModel::EachValidator
      def initialize(options)
        options[:message]     ||= 'is not a valid ISSN code'
        options[:allow_nil]   ||= false
        options[:allow_blank] ||= false
        super(options)
      end

      def validate_each(record, attribute, value)
        unless validate_with_issn(value) || (value.nil? && options[:allow_nil]) || (value.blank? && options[:allow_blank])
          record.errors.add(attribute, options[:message])
        end
      end

      private

      def validate_with_issn(issn) #:nodoc:
        if (issn || '').match(ISSN_REGEX)
          issn_values = issn.upcase.gsub(/\ |-/, '').split('')
          check_digit = issn_values.last # last digit is check digit
          check_digit = (check_digit == 'X') ? 10 : check_digit.to_i

          sum = 0
          issn_values.each_with_index do |value, index|
            sum += (issn_values.length - index) * value.to_i
          end
          sum += 10 if (check_digit == 10)

          (sum % 11) == 0
        else
          false
        end
      end
    end

    module HelperMethods
      def validates_issn(*attr_names)
        validates_with IssnFormatValidator, _merge_attributes(attr_names)
      end
    end
  end
end

ActiveModel::Validations::HelperMethods.send(:include, ValidationExtensions::IssnValidation::HelperMethods)
ActiveModel::Validations::IssnFormatValidator = ValidationExtensions::IssnValidation::IssnFormatValidator

