require 'pg'
require_relative '../db/sql_runner.rb'

class Artist

    attr_reader :id
    attr_accessor :name

    def initialize(options)
        @name = options['name']
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO artists (name) VALUES ($1)
        RETURNING id;"
        values = [@name]
        result = SqlRunner.run(sql, "save_artist", values)
        @id = result[0]["id"].to_i
    end

    def self.find(id)
        sql = "SELECT * FROM artists where id = $1"
        values = [id]
        result = SqlRunner.run(sql, "find_artist_by_id", values)
        artist = result[0]
        return Artist.new(artist)
    end

    def self.all()
        sql = "SELECT * FROM artists;"
        values = []
        result = SqlRunner.run(sql, "all_artists", values)
        result.map { |artist_hash| Artist.new(artist_hash) }
    end

    def update()
        sql = "UPDATE artists SET (name) = ($1) WHERE id = $2"
        values = [@name, @id]
        result = SqlRunner(sql, "update_artist", values)
    end

    def delete()
        sql = "DELETE FROM artists WHERE id = $1;"
        values = [@id]
        result = SqlRunner(sql, "delete_artist", values)
    end

    def self.delete_all()
        sql = "DELETE FROM artists"
        values = []
        result = SqlRunner.run(sql, "delete_all_artists", values)
    end

    def find_albums()
        sql = "SELECT * FROM albums WHERE artist_id = $1;"
        values = [@id]
        result = SqlRunner.run(sql, "find_albums", values)
        return result.map { |album_hash| Album.new(album_hash)}
    end

end
