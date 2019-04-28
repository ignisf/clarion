class CreateFeedbacks < ActiveRecord::Migration[4.2]
  def change
    create_table :feedbacks do |t|
      t.references :feedback_receiving, index: {name: :feedbacks_polymorphic_index}, polymorphic: true, null: false
      t.string :author_email
      t.integer :rating, null: false
      t.text :comment, null: false
      t.string :ip_address
      t.string :session_id, index: true

      t.timestamps null: false
    end
  end
end
