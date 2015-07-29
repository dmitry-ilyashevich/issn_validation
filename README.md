# IssnValidation

Custom ActiveRecord Validation for International Standard Book Number (ISSN)
fields. Will guarantee that validated fields contain valid ISSNs.

For more information on ISSN, see http://en.wikipedia.org/wiki/Issn

## Installation

To use it, add it to your Gemfile:

    gem 'issn_validation'

The current version of issn_validation only supports Rails 3+

## Example

    class Magazine < ActiveRecord::Base
      validates :issn, issn_format: true
    end

Copyright &copy; 2015 Dmitry A. Ilyashevich, released under the MIT license

