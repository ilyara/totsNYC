class Lena < Netzke::Basepack::BorderLayoutPanel
  def configuration
    super.merge(
      :header => false,
      :items => [{
        :region => :center,
        :title => "Projects",
        :name => "tasks",
        :class_name => "Netzke::Basepack::GridPanel",
        :model => "Task"
      },{
        :region => :east,
        :title => "Info",
        :width => 240,
        :split => true,
        :name => "info",
        :class_name => "Netzke::Basepack::Panel"
      },{
        :region => :south,
        :title => "Tasks",
#        :height => 150,
        :split => true,
        :name => "sub_tasks",
        :class_name => "Netzke::Basepack::GridPanel",
        :model => "SubTask"
      }]
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
        this.getComponent('sub_tasks').getStore().load();
        // this.getComponent('task_details').updateStats();
      }, this);
    }
  JS
  
  # js_method :init_component, <<-JS
  #   function(){
  #     // calling superclass's initComponent
  #     #{js_full_class_name}.superclass.initComponent.call(this);
  # 
  #     // setting the 'rowclick' event
  #     this.getChildNetzkeComponent('tasks').on('rowclick', this.onTaskSelectionChanged, this);
  #   }
  # JS

  # Event handler
  js_method :on_task_selection_changed, <<-JS
    function(self, rowIndex){
      alert("Task id: " + self.store.getAt(rowIndex).get('id'));
    }
  JS

  endpoint :select_task do |params|
    {
      :sub_tasks => {:set_title => params[:task_id]}
    }
  end
  
  def select_task(params)
    logger.debug "!!! params[:task_id]: #{params[:task_id]}\n"
  end
  
end