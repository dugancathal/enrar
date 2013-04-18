class CreateTest < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :stuff
    end
  end
end
