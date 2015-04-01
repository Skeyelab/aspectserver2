migration 1, :create_desks do
  up do
    create_table :desks do
      column :id, Integer, :serial => true
      
    end
  end

  down do
    drop_table :desks
  end
end
