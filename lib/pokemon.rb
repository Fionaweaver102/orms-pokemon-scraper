class Pokemon
    attr_accessor :name, :type, :id, :db

    def initialize(id:, name:, type:, db:)
        @name = name 
        @type = type 
        @id = id 
        @db = {:conn => SQLite3::Database.new("db/pokemon.db")}
    end 

    def self.save(name, type, db)
        sql = <<-SQL 
        INSERT INTO pokemon (name, type)
        VALUES (?, ?);
        SQL

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end 

    def self.find(id, db)
        pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?;", id).flatten
        Pokemon.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: pokemon[3])
    end 


end
