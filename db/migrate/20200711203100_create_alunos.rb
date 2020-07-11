class CreateAlunos < ActiveRecord::Migration[6.0]
  def change
    create_table :alunos do |t|
      t.string :nome
      t.integer :rm
      t.references :sala, null: false, foreign_key: true

      t.timestamps
    end
  end
end
