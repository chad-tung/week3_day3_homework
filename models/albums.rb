require 'pg'
require_relative '../db/sql_runner.rb'

class Album

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title']
        @genre = options['genre']
        @artist_id = options['artist_id'].to_i
    end

    def save()
        sql = "INSERT INTO albums (title, genre, artist_id)
        VALUES ($1, $2, $3) RETURNING id;"
        values = [@title, @genre, @artist_id]
        result = SqlRunner.run(sql, "save_album", values)
        @id = result[0]["id"].to_i
    end

    def self.all()
        sql = "SELECT * FROM albums;"
        values = []
        result = SqlRunner.run(sql, "select_all_albums", values)
        return result.map { |album_hash| Album.new(album_hash) }
    end

    def self.delete_all()
        sql = "DELETE FROM albums;"
        values = []
        result = SqlRunner.run(sql, "delete_all_albums", values)
    end

    def find_artist()
        sql = "SELECT * FROM artists WHERE id = $1"
        values = [@artist_id]
        result = SqlRunner.run(sql, "find_artist", values)
        artist = result[0]
        return Artist.new(artist)
        #return result.map { |artist_hash| Artist.new(artist_hash)}
    end
end
