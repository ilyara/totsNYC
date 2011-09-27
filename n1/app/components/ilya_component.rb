class IlyaComponent < Netzke::Basepack::BorderLayoutPanel
  js_property :header, false

  def configuration
    super.merge(
      :persistence => true,
      :items => [
        :tasks.component(
          :region => :center,
          :title => "Tasks"
        ),
        :sub_tasks.component(
          :region => :south,
          :title => "SubTasks",
          :height => 250,
          :split => true
        )
      ]
    )
  end

  # Overriding initComponent
  js_method :init_component, <<-JS
    function(){
      // calling superclass's initComponent
      this.callParent();

      // setting the 'rowclick' event
      var view = this.getComponent('tasks').getView();
      view.on('itemclick', function(view, record){
        // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
        this.selectTask({task_id: record.get('id')});
        this.getComponent('subt_task').getStore().load();
      }, this);
    }
  JS

  endpoint :select_boss do |params|
    # store selected boss id in the session for this component's instance
    component_session[:selected_task_id] = params[:task_id]
  end

  component :tasks do
    {
      :class_name => "Basepack::GridPanel",
      :model => "Task"
    }
  end

  component :sub_tasks do
    {
      :class_name => "Netzke::Basepack::GridPanel",
      :model => "SubTask",
      :load_inline_data => false,
      :scope => {:task_id => component_session[:selected_task_id]},
      :strong_default_attrs => {:task_id => component_session[:selected_task_id]}
    }
  end

end
