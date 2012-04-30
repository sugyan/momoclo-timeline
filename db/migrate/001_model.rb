Sequel.migration do
  change do
    create_table(:official_events) do
      primary_key :id
      String :name, :null => false
      String :place
      String :image
      Date :date, :null => false
    end
  end
end
