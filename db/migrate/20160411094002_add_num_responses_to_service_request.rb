class AddNumResponsesToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :num_responses, :integer
  end
end
