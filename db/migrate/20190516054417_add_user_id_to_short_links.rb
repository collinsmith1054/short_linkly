class AddUserIdToShortLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :short_links, :user_id, :integer, null: false, unique: true
    remove_index :short_links, name: :index_short_links_on_long_link
    add_index :short_links, [:user_id, :long_link], unique: true
  end
end
