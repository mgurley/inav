# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_inav_session',
  :secret      => '6c1da69689038dfb475e27bd3312cb3ec700b54efffcba8e3af597e44e9ac87ecd731b06af4ce60ad221f663cb93deca404be955797ce462aee4ba05a8d9d32e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
