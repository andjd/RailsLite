require_relative '../phase5/controller_base'
require_relative 'router'
require_relative '../flash'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(action_name)

      self.send(action_name)
    end

  end
end
