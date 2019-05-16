class CreateShortLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :short_links do |t|
      t.string :long_link, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
