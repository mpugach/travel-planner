class AddSearchVectorToTrips < ActiveRecord::Migration[5.0]
  def up
    add_column :trips, :search_vector, 'tsvector'

    add_index :trips, :search_vector, using: :gin

    execute <<-SQL.strip_heredoc.strip.gsub(/\s+/, ' ')
      DROP TRIGGER IF EXISTS trips_search_vector_update ON trips;

      CREATE TRIGGER trips_search_vector_update
      BEFORE INSERT OR UPDATE
      ON trips
      FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger (search_vector, 'pg_catalog.english', destination, comment);
    SQL

    # It is just a demo, do not repeat the following statement on large production dataset
    Trip.find_each(&:touch)
  end

  def down
    remove_column :trips, :search_vector

    execute <<-SQL.strip_heredoc.strip.gsub(/\s+/, ' ')
      DROP TRIGGER IF EXISTS trips_search_vector_update on trips;
    SQL
  end
end
