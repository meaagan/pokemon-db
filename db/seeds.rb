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
        number: row['#'],
        name: "#{row['Name']}",
        type_1:  "#{row['Type 1']}", 
        type_2: "#{row['Type 2']}", 
        total: row['Total'], 
        hp: row['HP'], 
        attack: row['Attack'], 
        defense: row['Defense'], 
        sp_atk: row['Sp. Atk'], 
        sp_def:row['Sp. Def'], 
        speed:row['Speed'],
        generation: row['Generation'],
        legendary: row['Legendary'].downcase
    )
    puts "Created #{row['Name']}"
end

puts "Finished!"