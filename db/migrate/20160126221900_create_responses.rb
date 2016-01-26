class CreateResponses < ActiveRecord::Migration
  def change
    create_table(:responses) do |t|
      t.column(:the_response, :string)
      t.column(:question_id, :integer)

      t.timestamps()
    end
  end
end
