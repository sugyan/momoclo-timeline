Sequel.migration do
  change do
    rename_table(:official_events, :events)
  end
end
