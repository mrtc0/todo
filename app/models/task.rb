class Task < ApplicationRecord
  enum status: { todo: 0, doing: 1, done: 2 }

  validates :title,
    presence: { message: I18n.t('view.task.message.error.required') }

  validates :priority,
    numericality: { only_integer: true }, unless: :priority_is_nil?

  validate :expire_greater_than_current_time

  scope :filter_by_title, ->(title) { where('title like ?', "%#{title}%") unless title.nil? }
  scope :filter_by_status, ->(status) { where(status: status) unless status.nil? }
  scope :sort_by_expire, ->(sort) { sort == 'expire' ? order(expire_at: 'ASC') : order(created_at: 'DESC') }

  def priority_is_nil?
    priority.nil?
  end

  def expire_greater_than_current_time
    return if expire_at.nil?

    if expire_at <= Time.zone.now
      errors.add :base, I18n.t('view.task.message.error.expire_greater_than_current_time')
    end
  end

  def self.filter_by_title_and_status(params)
    filter_by_title(params[:title])
      .filter_by_status(params[:status])
      .sort_by_expire(params[:sort])
  end
end
