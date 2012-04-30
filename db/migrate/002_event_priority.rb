Sequel.migration do
  change do
    alter_table(:official_events) do
      add_column :enddate, Date
      add_column :importance, Integer, :default => 0
      add_index [:importance, :date]
      rename_column :place, :description
      rename_column :date, :startdate
    end
  end
end
