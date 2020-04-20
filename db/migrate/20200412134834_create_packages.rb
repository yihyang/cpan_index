class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|

      t.string :title
      t.bigint :latest_package_version_id, nullable: true

      t.index :title, unique: true

      t.timestamps
    end
  end
end
