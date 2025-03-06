module Bulky
  class Updater

    attr_reader :model, :bulk_update

    def initialize(model, bulk_update_id)
      @bulk_update = Bulky::BulkUpdate.find(bulk_update_id)
      @model       = model
    end

    def log
      @log ||= bulk_update.updated_records.build { |r| r.updatable = model }
    end

    def strong_updates
      ActionController::Parameters.new(bulk_update.updates)
    end

    def updates
      @updates ||= strong_updates.permit(*model.bulky_attributes)
    end

    def update!
      # FIXME: no depender de Pundit, habilitar un callback
      policy = Pundit.policy!(Current.user, model)
      unless policy.update?
        raise Pundit::NotAuthorizedError, query: :update, record: model, policy:
      end
      model.attributes      = updates
      log.updatable_changes = model.changes
      model.save!
    rescue => e
      log.error_message   = e.message
      log.error_backtrace = e.backtrace.join("\n")
      raise e
    ensure
      log.save! if log.updatable_changes.present?
    end
  end
end
