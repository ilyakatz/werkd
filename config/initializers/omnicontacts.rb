require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail,
    Figleaf::Settings.omnicontacts.google.client,
    Figleaf::Settings.omnicontacts.google.secret,
    max_results: 1000
  importer :yahoo,
    Figleaf::Settings.omnicontacts.yahoo.consumer,
    Figleaf::Settings.omnicontacts.yahoo.secret,
    max_results: 1000
end
