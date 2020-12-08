# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

filepath    = 'lib/csv/pokemon.csv'
csv_options = { col_sep: ',', headers: :first_row }

puts "Starting Seed..."
CSV.foreach(filepath, csv_options) do |row|
    Pokemon.create(
        number: row['#'].to_i,
        name: "#{row['Name']}",
        type_1:  "#{row['Type 1']}", 
        type_2: "#{row['Type 2']}", 
        total: row['Total'].to_i, 
        hp: row['HP'].to_i, 
        attack: row['Attack'].to_i, 
        defense: row['Defense'].to_i, 
        sp_atk: row['Sp. Atk'].to_i, 
        sp_def:row['Sp. Def'].to_i, 
        speed:row['Speed'].to_i,
        generation: row['Generation'].to_i,
        legendary: row['Legendary']
    )
    puts "Created #{row['Name']}"
end

puts "Finished!"