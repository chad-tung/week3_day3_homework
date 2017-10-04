require 'pg'
require_relative 'sql_runner.rb'

class Album

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title']
        @genre = options['genre']
        @artist_id = options['artist_id'].to_i
    end

    def save()
        sql = "INSERT * INTO albums (id, title, genre, artist_id)
        VALUES ($1, $2, $3, $4) RETURNING id;"
        values = [@id, @title, @genre, @artist_id]
        result = SqlRunner.run(tag, "save_album", values)
        @id = result[0]['id'].to_i
    end

    def self.all()
        sql = "SELECT * FROM albums;"
        values = []
        result = SqlRunner.run(tag, "select_all_albums", values)
        return result.map { |album_hash| Album.new(album_hash) }
    end

    def self.delete_all()
        sql = "DELETE FROM albums;"
        values = []
        result = SqlRunner.run(tag, "delete_all_albums", values)
    end
end
