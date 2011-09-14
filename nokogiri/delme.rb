require 'rubygems'
require 'sqlite3'

class MyDB
  
  def initialize(db_path="delme.sqlite3")
    puts "initializing"
    @db = SQLite3::Database.new(db_path)
    create_sql = <<SQL
        create table if not exists refs (id integer primary key, cl_url string, cl_description string, cl_area string);
SQL
    @db.execute_batch create_sql
    @db.execute "PRAGMA journal_mode=MEMORY"
    @db.execute "PRAGMA synchronous=OFF"
    @db.execute "PRAGMA temp_store=MEMORY"
    @db.execute "PRAGMA count_changes=OFF"
  end

  def bulk_insert(field_names, dataset)
    sql = "insert into refs (#{field_names.join(', ')}) values (?, ?, ?)"
    puts sql
    @db.prepare sql do |st|
      @db.transaction
        dataset.each do |r| 
          st.execute r # if t.to_s.scan(/(\d)\1+/).count == 0
        end
      @db.commit
    end
  end
end

f = %w'cl_url cl_description cl_area'
d = [
  ['a', 'b', 'c'],
  ['d', 'e', 'f'],
  ['g', 'h', 'i']
]

mydb = MyDB.new
mydb.bulk_insert f, d