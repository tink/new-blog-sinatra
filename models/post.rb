unless DB.table_exists? :posts
  DB.create_table :posts do
    primary_key :id
    varchar :titulo
    varchar :conteudo
  end
end

class Post < Sequel::Model
  one_to_many :comentarios
end
