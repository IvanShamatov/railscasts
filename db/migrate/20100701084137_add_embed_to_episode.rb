class AddEmbedToEpisode < ActiveRecord::Migration
  def self.up
    add_column :episodes, :embed, :text
  end

  def self.down
    remove_column :episodes, :embed
  end
end
