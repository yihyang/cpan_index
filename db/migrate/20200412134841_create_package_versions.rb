class CreatePackageVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :package_versions do |t|

      t.belongs_to :package
      t.string :version_number
      t.string :description
      t.datetime :publication_date
      t.string :status
      t.text :index_raw_data
      t.text :description_raw_data

      t.timestamps
    end
  end
end
