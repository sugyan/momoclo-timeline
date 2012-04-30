Sequel.migration do
  up do
    create_table(:episode_types) do
      primary_key :id
      String :name, :text => true, :null => false
    end

    create_table(:episodes) do
      primary_key :id
      Bignum      :user_id, :null => false
      Integer     :type,    :null => false
      String      :text,    :text => true, :null => false
      Date        :date,    :null => false
      Integer     :term
      DateTime    :created_at
    end

    create_table(:official_events, :ignore_index_errors => true) do
      primary_key :id
      String :name,  :size => 255, :null=>false
      String :place, :size => 255
      String :image, :size => 255
      Date   :date,  :null => false

      index [:date]
    end

    create_table(:users) do
      Bignum :id,          :null => false
      String :screen_name, :size => 16,  :null => false
      String :name,        :size => 255, :null => false
      String :image,       :size => 255, :null => false
      String :description, :text => true
      DateTime :created_at

      primary_key [:id]
    end
  end

  down do
    drop_table(:users, :official_events, :episodes, :episode_types)
  end
end
