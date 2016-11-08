# Mostrar todos los post
# Mostrar un post determinado
# Crear un post nuevo
# Editar un post existente
# Eliminar un post existente

post '/post' do
  titulo = params["post"]["title"]
  post = params["post"]["message"]
  tag = params["post"]["tags"]

  post_now = Post.create(titulo: titulo, mensaje: post)

  lista = tag.split(",")                        # separar tags en un arreglo
    lista.each do |t|                           # recorrer lista
      t = t.rstrip.lstrip                         # quitar espacios
      t.downcase!
      
      dato = Tag.find_by(etiquetas: t)

      if dato.nil?                                  # si no existe crealo
        tag_creado = Tag.create(etiquetas: t)       # creando registro en la tabla tags
      else                                          # si existe buscalo
        tag_creado = Tag.find_by(etiquetas: t)
      end

      post_now.blogs.create(tag: tag_creado)      # crear registro en la tabla blog de ambos id
      post_now.tags                               #=> <ActiveRecord::Associations::CollectionProxy [#<id: 1, post id: 1, blog id: 1, created_at: "2016-01-25 18:45:00", updated_at: "2016-01-25 18:45:00"]>
    end

  redirect to '/'
end

get '/show_all' do
  @blog = Post.all
  if @blog.empty?
    erb :index
  else
    erb :show_all
  end
end

get '/find' do
  erb :find
end