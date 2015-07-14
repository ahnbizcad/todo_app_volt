# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    model :store

    def index
      StatTask.show_stats #instance method on class level is volt convention.
      .then do |stats|
        page._info = stats
      end.fail do |error|
        page._info  = error
      end
    end

    def about
      # Add code for when the about view is loaded
    end

    def add_todo
      _todos << page._new_todo.to_h # hash going into existing collection gets converted to model
      page._new_todo._label = ''
    end

    def incomplete_count
      _todos.count { |t| !t._completed }
    end

    def complete_all
      _todos.each { |t| t._completed = true }
    end

    def clear_completed
      _todos.select { |t| t._completed }.each(&:destroy)
    end


    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
