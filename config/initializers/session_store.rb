# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_review_site2_session',
  :secret      => '549c6ceecadfe9806c9c69ae2192bf8247d7d6289e49d298dc6c330e4da1afb313bb80dbc2cb593728ca18b1db26240ee906289e63d8205ce959b43f8520af29'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
