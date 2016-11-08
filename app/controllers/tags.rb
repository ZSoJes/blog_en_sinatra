# Mostrar todos los posts con cierto Tag.
before "/find" do 
  if params[:error] == 'true'
    @error = "No dejes el campo vacio"
  end
end

post '/tag' do
@post_resultado = []

  tag_text = params[:tag_find]
puts tag_text
puts tag_text.nil?
  unless tag_text.empty?
    tag_text.downcase!
    dato = Tag.find_by(etiquetas: tag_text)
    @post_find = Blog.where(tag_id: dato.id)

    @post_find.each do |t| 
      @post_resultado << Post.where(id: t.post_id) 
    end
  erb :find
  else
  redirect to '/find?error=true'  
  end
end
