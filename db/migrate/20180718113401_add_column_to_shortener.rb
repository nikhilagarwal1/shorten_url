class AddColumnToShortener < ActiveRecord::Migration[5.1]
  def change
    add_column :shorteners, :sanitized_url, :string
  end
end
