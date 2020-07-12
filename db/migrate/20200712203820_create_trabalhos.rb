class CreateTrabalhos < ActiveRecord::Migration[6.0]
  def change
    create_table :trabalhos do |t|
      t.string :title
      t.string :url
      t.references :aluno, null: false, foreign_key: true

      t.timestamps
    end
  end
end
