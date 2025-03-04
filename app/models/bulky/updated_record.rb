class Bulky::UpdatedRecord < ActiveRecord::Base
  self.table_name = 'bulky_updated_records'

  # updatable_changes can be blank on a mass assignment security violation
  validates :bulk_update_id, :updatable, presence: true

  belongs_to :bulk_update, class_name: 'Bulky::BulkUpdate', foreign_key: :bulk_update_id
  belongs_to :updatable, polymorphic: true
end
