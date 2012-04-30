Sequel.migration do
 up do
    alter_table(:official_events) do
      drop_index :startdate
    end
  end

  down do
    alter_table(:official_events) do
      add_index :startdate
    end
  end
end
