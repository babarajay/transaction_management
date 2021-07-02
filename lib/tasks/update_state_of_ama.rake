namespace :update_state_of_ama do
  desc "Task to update current state of AMA"
  task update: :environment do
    amas = Ama.where.not(state: 'completed')
    amas.each do |ama|
      next_state = ama.next_state
      ama.validate_current_state_update(next_state)
      ama.update(state: next_state) unless ama.errors[:state].any?
    end
  end
end
