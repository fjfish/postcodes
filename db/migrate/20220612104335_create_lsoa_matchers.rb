class CreateLsoaMatchers < ActiveRecord::Migration[7.0]
  def change
    create_table :lsoa_matchers do |t|
      t.string :name, null: false
      t.json :match_strings, default: []
      t.json :extra_postcodes, default: []

      t.timestamps
    end
  end
end
