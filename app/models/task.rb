class Task < ApplicationRecord
  enum status: { todo: 0, doing: 1, done: 2 }

  validates :title,
    presence: { message: I18n.t('view.task.message.error.required') }

  validates :priority,
    numericality: { only_integer: true }, unless: :priority_is_nil?

  validate :expire_greater_than_current_time

  def priority_is_nil?
    priority.nil?
  end

  def expire_greater_than_current_time
    return if expire_at.nil?

    if expire_at <= Time.zone.now
      errors.add :base, I18n.t('view.task.message.error.expire_greater_than_current_time')
    end
  end
end
