class CreateProjects < ActiveRecord::Migration[7.0] def change create_table
:projects do |t| t.string :title t.string :description t.date :start_date t.date
:completion_date t.timestamps end end end
