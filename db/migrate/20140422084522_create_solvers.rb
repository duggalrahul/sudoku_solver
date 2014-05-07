class CreateSolvers < ActiveRecord::Migration
  def change
    create_table :solvers do |t|

      t.timestamps
    end
  end
end
