When(/^I click "(.*?)" icon within "(.*?)"$/) do |link_selector, selector|
  with_scope(selector) do
    find(link_selector).click
  end
end
