class CreatePackageVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :package_versions do |t|

      t.belongs_to :package
      t.string :version_number
      t.string :description
      t.bigint :maintainer_id, nullable: true
      t.datetime :publication_date
      t.string :status
      t.text :index_raw_data
      t.text :description_raw_data

      t.index [:package_id, :version_number], unique: true

      t.timestamps
    end
  end
end
