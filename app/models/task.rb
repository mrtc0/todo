class Task < ApplicationRecord
  belongs_to :user
  enum status: { todo: 0, doing: 1, done: 2 }
  enum priority: { non: 0, low: 1, meddium: 2, high: 3 }

  validates :title,
    presence: { message: I18n.t('view.task.message.error.required') }

  validate :expire_greater_than_current_time

  scope :filter_by_title, ->(title) { where('title like ?', "%#{title}%") unless title.blank? }
  scope :filter_by_status, ->(status) { where(status: status) unless status.blank? }
  scope :sort_by_expire, ->(sort) { sort == 'expire' ? order(expire_at: 'ASC') : order(created_at: 'DESC') }

  scope :sort_by_priority, ->(priority) { priority == 'desc' ? order(priority: 'DESC') : order(priority: 'ASC') }

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
