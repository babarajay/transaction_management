namespace :update_state_of_ama do
  desc "Task to update current state of AMA"
  task update: :environment do
    amas = Ama.where.not(state: 'completed')
    amas.each do |ama|
      ama.refresh_state
    end
  end
end
