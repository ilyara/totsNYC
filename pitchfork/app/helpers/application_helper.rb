module ApplicationHelper
  def avatar(user)
    "https://graph.facebook.com/" + user.username + "/picture" #"?type=square"
  end
  def tables
    x = ActiveRecord::Base.connection.tables
    x.delete 'schema_migrations'
    x
  end
end
