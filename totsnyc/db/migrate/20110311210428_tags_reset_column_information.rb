class TagsResetColumnInformation < ActiveRecord::Migration
  def self.up
    Tag.reset_column_information
  end

  def self.down
  end
end
