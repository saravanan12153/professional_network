class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true
      t.references :invited, index: true

      t.timestamps null: false
    end
  end
end
