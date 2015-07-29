ActiveRecord::Schema.define(version: 1) do
  create_table :magazines, force: true do |t|
    t.string :issn
  end
end

