class AddOnboardingCompletedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :onboarding_completed_at, :time
  end
end
