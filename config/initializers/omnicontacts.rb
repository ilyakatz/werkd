require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail,
    "167144929226-43tdrbru81nhctrqjrps2leq5nu6s3ht.apps.googleusercontent.com",
    "-7BF5WIdnB8aLadPDgZcwK9O"
end
