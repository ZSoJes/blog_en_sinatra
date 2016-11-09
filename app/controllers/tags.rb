# Mostrar todos los posts con cierto Tag.
before "/find" do                             # evaluar errores 
  if params[:error] == 'true'
    @error = "No dejes el campo vacio"
  elsif params[:error] == 'true_'
    @error = "Error! POST no encontrado"
  end

end

post '/tag' do
@post_resultado = []
  tag_text = params[:tag_find]

  unless tag_text.empty?
    tag_text.downcase!
    dato = Tag.find_by(etiquetas: tag_text)
    @post_find = Blog.where(tag_id: dato.id)

    @post_find.each do |t| 
      @post_resultado << Post.where(id: t.post_id) 
    end

    evalua_post_existe =""
    @post_resultado.each do |temp|
      temp.each do |t1|
        evalua_post_existe = t1
      end
    end

    if evalua_post_existe.empty?
      redirect to '/find?error=true_'
    else
      erb :find
    end

  else
  redirect to '/find?error=true'  
  end
end

get'/tag/:palabra' do                 # si se desea cargar una consulta desde la url
  @post_resultado = []
  tag_text = params[:palabra]
  @tag_buscar = Tag.find_by(etiquetas: tag_text)

  unless @tag_buscar.nil?
  @post_find =  Blog.where(tag_id: @tag_buscar.id)

    @post_find.each do |t| 
      @post_resultado << Post.where(id: t.post_id) 
    end
  
  evalua_post_existe =""
    @post_resultado.each do |temp|
      temp.each do |t1|
        evalua_post_existe = t1
      end
    end

    if evalua_post_existe.empty?
      redirect to '/find?error=true_'
    else
      erb :find
    end

  else
  redirect to '/find?error=true'  
  end
end