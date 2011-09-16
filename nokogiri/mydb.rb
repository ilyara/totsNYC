class MyDB
  attr_reader :db
  def initialize(db_path="devX.sqlite3")
    @db = SQLite3::Database.new(db_path)
    # drop table if exists refs;
    create_sql = <<SQL
        create table if not exists refs 
        (id integer primary key, cl_ref string, cl_url string, cl_title string, cl_description string,
        cl_area string, cl_issued datetime, source string, status string, load_time datetime);
        create unique index if not exists idx_cl_url_refs on refs(cl_url);
        create unique index if not exists idx_cl_ref_refs on refs(cl_ref);
SQL
    @db.execute_batch create_sql
    @db.execute "PRAGMA journal_mode=MEMORY"
    @db.execute "PRAGMA synchronous=OFF"
    @db.execute "PRAGMA temp_store=MEMORY"
    @db.execute "PRAGMA count_changes=NO"
  end

  def bulk_insert(field_names, dataset)
    pattern = (['?'] * field_names.count).join(', ')
    sql = "insert or ignore into refs (#{field_names.join(', ')}) values (#{pattern})"
    @db.prepare sql do |st|
      @db.transaction
        dataset.each do |r| 
          st.execute r
        end
      @db.commit
    end
  end
end