Sequel.migration do
  up do
    alter_table(:episodes) do
      drop_column :term
      add_column :enddate, Date
      rename_column :date, :startdate
    end
  end

  down do
    alter_table(:episodes) do
      add_column :term, Integer
      drop_column :enddate
      rename_column :startdate, :date
    end
  end
end
