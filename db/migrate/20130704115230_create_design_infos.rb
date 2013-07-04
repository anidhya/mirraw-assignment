class CreateDesignInfos < ActiveRecord::Migration
  def change
    create_table :design_infos do |t|
      t.string :name
      t.string :price
      t.references :designer

      t.timestamps
    end
  end
end
