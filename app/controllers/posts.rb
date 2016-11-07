# Mostrar todos los post
# Mostrar un post determinado
# Crear un post nuevo
# Editar un post existente
# Eliminar un post existente
get '/post' do
  redirect to '/'
end
post '/post' do
  # titulo = params["post"]["title"]
  # post = params["post"]["message"]
  tag = params["post"]["tags"]
  
  titulo = params[:title]
  titulo = params[:message]
  post_now = Post.create(titulo: titulo, mensaje: post)

  lista = tag.split(",")                        # separar tags en un arreglo
    lista.each do |t|                           # recorrer lista
    t = t.rstrip.lstrip                         # quitar espacios
    tag_creado = Tag.create(etiquetas: t)       # creando registro en la tabla tags
    post_now.blogs.create(tag: tag_creado)      # crear registro en la tabla blog de ambos id
    post_now.tags                               #=> <ActiveRecord::Associations::CollectionProxy [#<id: 1, post id: 1, blog id: 1, created_at: "2016-01-25 18:45:00", updated_at: "2016-01-25 18:45:00"]>
  end

  redirect to '/'
end

get '/show_all' do
  erb :show_all_post
end

# post '/show_all' do
#   erb :show_all_post
# end

get '/find' do
  erb :find_edit
end

# post '/find' do
#   erb :find_edit
# end