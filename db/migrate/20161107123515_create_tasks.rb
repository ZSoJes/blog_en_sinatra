class CreateTasks < ActiveRecord::Migration
  def change
    create_table :posts do |ps|
      ps.string :titulo
      ps.string :mensaje
    end

    create_table :tags do |ts|
      ts.string :etiquetas
    end

    create_table :blogs do |bs|
      bs.belongs_to :post, index: true
      bs.belongs_to :tag, index: true
      bs.timestamps
    end
  end
end
