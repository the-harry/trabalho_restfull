class AddTokenAndTokenExpToAluno < ActiveRecord::Migration[6.0]
  def change
    add_column :alunos, :token, :string
    add_column :alunos, :token_exp, :date_time
  end
end
