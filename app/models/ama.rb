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
  ## Validate the current state while state transition
  #
  def validate_current_state_update(next_state)
    time = live? ? updated_at : start_date
    time_diff = (Time.now - time)/1.hour

    case state
    when 'unstart', 'preparing'
      return if time_diff > 1
      errors.add(:state, "AMA can not be modified from #{state} to #{next_state} until 1 hour from #{state}")
    when 'live'
      return if time_diff > 24
      errors.add(:state, "AMA can not be modified from #{state} to #{next_state} until 24 hour from #{state}")
    end
  end

  #
  ## Validate date start date
  #
  def start_date_must_be_in_future
    if start_date.present? && start_date < Time.now
      errors.add(:start_date, "can't be in the past")
    end
  end

  #
  ## Get next state for object
  #
  def next_state
    case state
    when 'unstart'
      'preparing'
    when 'preparing'
      'live'
    when 'live'
      'finished'
    when 'finished'
      'completed'
    end
  end

  #
  ## Refresh state
  #
  def refresh_state
    new_state = next_state
    validate_current_state_update(new_state)
    update(state: new_state) unless errors[:state].any?
  end
end
