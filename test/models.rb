class Magazine < ActiveRecord::Base
  validates :issn, issn_format: { message: 'is too fantastical!' }
end

class Magazine10 < ActiveRecord::Base
  self.table_name = 'magazines'
  validates :issn, issn_format: { allow_blank: true }
end

class Magazine13 < ActiveRecord::Base
  self.table_name = 'magazines'
  validates :issn, issn_format: { allow_nil: true }
end

class OldMagazine < ActiveRecord::Base
  self.table_name = 'magazines'
  validates_issn :issn
end

