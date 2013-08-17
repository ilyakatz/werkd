When /^(?:|I )follow the first "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link, match: :first)
  end
end

