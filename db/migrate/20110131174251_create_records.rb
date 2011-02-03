class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.references :user
      t.boolean :iotype
      t.integer :amount
      t.string :payee
      t.integer :payee_id
      t.string :payer
      t.integer :payer_id
      t.string :caption
      t.string :remark
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :records
  end
end
