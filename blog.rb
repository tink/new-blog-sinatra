require 'rubygems'
require 'sinatra/base'

require 'yaml'
require 'sequel'

DB = Sequel.sqlite('./db/blog.db')

require 'models/post'

class Blog < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/posts' do
    @posts = Post.all.reverse!

    erb :posts
  end

  get '/novo_post' do
    erb :novo_post
  end

  post '/novo_post' do
    Post.create(params['post'])

    redirect '/'
  end

  get '/novo_comentario/:post_id' do
    @post = Post.find(params['post_id'])
    erb :novo_comentario   
  end

  post '/posts/:post_id/comentarios' do
    @post = Post.find(params['post_id'])
    @post.comentarios.create(params['comentario'])

    redirect_to "/posts/#{@post.id}"
  end

  get '/procurar' do
    erb :procurar
  end

  post '/procurar' do
    @posts = Post.filter(:titulo.like("%#{params['busca_titulo']}%"))
    erb :posts
  end
end
