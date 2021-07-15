class Ama < ApplicationRecord
  #
  ## Associations
  #
  belongs_to :speaker, class_name: 'User'

  #
  ## Enum
  #
  enum state: {'unstart': 1, 'preparing': 2, 'live': 3, 'finished': 4, 'completed': 5}

  #
  ## Validations
  #
  validate :start_date_must_be_in_future, on: :create

  #
  ## Validate date start date
  #
  def start_date_must_be_in_future
    if start_date.present? && start_date < Time.now
      errors.add(:start_date, "can't be in the past")
    end
  end

  #
  ## Refresh state
  #
  def refresh_state
    if Time.now.between?(start_date - 1.hour, start_date)
      update(state: 'preparing')
    elsif Time.now.between?(start_date, start_date + 1.hour)
      update(state: 'live')
    elsif (((Time.now - start_date.to_time)/3600).round).eql?(2)
      update(state: 'finished')
    elsif (((Time.now - start_date.to_time)/3600).round).eql?(24)
      update(state: 'completed')
    end
  end
end
