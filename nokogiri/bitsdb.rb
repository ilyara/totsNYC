require 'sqlite3'

class MyDB
  attr_reader :db
  def initialize(db_path="devX.sqlite3", create_sql=[])
    @db = SQLite3::Database.new(db_path)
    create_sql = [create_sql] if create_sql.is_a?(String)
    create_sql.each {|sql| @db.execute_batch sql} if not create_sql.empty?
    @db.execute "PRAGMA journal_mode=MEMORY"
    @db.execute "PRAGMA synchronous=OFF"
    @db.execute "PRAGMA temp_store=MEMORY"
    @db.execute "PRAGMA count_changes=NO"
  end

  def bulk_insert(table_name, field_names, dataset)
    pattern = (['?'] * field_names.count).join(', ')
    sql = "insert or ignore into #{table_name} (#{field_names.join(', ')}) values (#{pattern})"
    # puts sql
    @db.prepare sql do |st|
      @db.transaction
        dataset.each do |r| 
          st.execute r
        end
      @db.commit
    end
  end
end