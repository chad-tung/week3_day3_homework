require 'pg'
require_relative 'sql_runner.rb'

class Artist

    attr_reader :id, :name

    def initialize(options)
        @name = options['name']
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT * INTO artists (id, name) VALUES ($1, $2)
        RETURNING id;"
        values = [@id, @name]
        result = SqlRunner.run(spl, "save_artist", values)
        @id = result[0]["id"].to_i
    end

    def self.all()
        sql = "SELECT * FROM artists;"
        values = []
        result = SqlRunner.run(spl, "all_artists", values)
        result.map { |artist_hash| Artist.new(artist_hash) }
    end

    def self.delete_all()
        sql = "DELETE FROM artists"
        values = []
        result = SqlRunner.run(spl, "delete_all_artists", values)
    end

end
