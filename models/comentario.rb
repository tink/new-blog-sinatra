unless DB.table_exists? :comentarios
  DB.create_table :comentarios do
    primary_key :id
    foreign_key :post_id, :posts
    varchar :autor
    varchar :conteudo
  end
end

class Comentario < Sequel::Model
  many_to_one :posts
end
