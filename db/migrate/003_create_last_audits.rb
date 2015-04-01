migration 3, :create_last_audits do
  up do
    create_table :last_audits do
      column :id, Integer, :serial => true
      
    end
  end

  down do
    drop_table :last_audits
  end
end
