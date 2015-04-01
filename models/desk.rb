class Desk
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :domain, String, :unique => true
  property :alias, String
  property :contact_email, String
  property :api_user, String
  property :api_key, String
  property :active, Boolean, :default => true

  has n, :last_audits, :constraint =>:destroy

end
