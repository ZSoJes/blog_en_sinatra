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

post '/post_delete' do
  dato = params[:delete_post]
  dato = dato.to_i
  @post = Post.find_by(id: dato)
  @post.destroy
  redirect to '/find'
end


post "/show_edit" do
  dato = params[:buscar_editar]
  @dato = dato.to_i
  @post_datos = Post.find_by(id: @dato)

  @tag_finder = Blog.where(post_id: @dato)
  @tag_lista = []
  @tag_finder.each do |t|
    @nombre_tag = Tag.find_by(id: t.tag_id)
    @tag_lista << @nombre_tag.etiquetas
  end
  @post_datos
  @tag_lista
  @dato
  erb :edit
end

post '/post_edit' do
  puts "::::::::::::::::::::::::::::::::::::::::::::::::"
  @dato = params[:dato]
  puts @dato
  puts "::::::::::::::::::::::::::::::::::::::::::::::::"

  @titulo = params[:title]
  @post = params[:message]
  
  puts @titulo
  puts @post
# class Post < ActiveRecord::Base
#   has_many :comments, autosave: true
# end

# =>  si funciona
post = Post.find(@dato)
post.titulo = @titulo
post.mensaje = @post
post.save
post.reload

# post.tags.ids
# detect_tag = Blog.where(post_id: @dato)
# detect_tag.each do |q|
#   tag_actual = Tag.find_by(id: q)

#   tag_actual.etiquetas = titulo
#   post.mensaje = post
#   post.save
#   post.reload
# end
  # @post_edit = Post.find_by(id: @dato)
  # @post_edit.update(titulo: titulo,mensaje: post)

  # @blog_edit = Blog.where(pots_id: @dato)
  redirect to '/find'
end
