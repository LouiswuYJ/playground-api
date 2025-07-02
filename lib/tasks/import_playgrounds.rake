namespace :playgrounds do
  desc "Import playground data from CSV file"
  task import_csv: :environment do
    csv_file = ENV['CSV_FILE'] || 'playgrounds.csv'

    if File.exist?(csv_file)
      require 'csv'

      CSV.foreach(csv_file, headers: true) do |row|
        playground_data = {
          name: row['name'],
          address: row['address'],
          description: row['description'],
          latitude: row['latitude']&.to_f,
          longitude: row['longitude']&.to_f,
          amenities: row['amenities'],
          age_group: row['age_group'],
          opening_hours: row['opening_hours'],
          contact_info: row['contact_info']
        }

        playground = Playground.find_or_initialize_by(name: playground_data[:name], address: playground_data[:address])
        playground.assign_attributes(playground_data)

        if playground.save
          puts "✓ Imported: #{playground.name}"
        else
          puts "✗ Failed to import: #{playground.name} - #{playground.errors.full_messages.join(', ')}"
        end
      end

      puts "\nImport completed!"
    else
      puts "CSV file not found: #{csv_file}"
    end
  end

  desc "Import sample playground data"
  task import_sample: :environment do
    sample_playgrounds = [
      {
        name: "Bishan-Ang Mo Kio Park Playground",
        address: "1384 Ang Mo Kio Ave 1, Singapore 569932",
        description: "A large playground with multiple play areas for different age groups, featuring slides, swings, and climbing structures.",
        latitude: 1.3691,
        longitude: 103.8454,
        amenities: '["slides", "swings", "climbing structures", "sand pit", "water play area"]',
        age_group: "2-12 years",
        opening_hours: "24 hours",
        contact_info: "NParks Hotline: 1800-471-7300"
      },
      {
        name: "East Coast Park Playground",
        address: "East Coast Park Service Road, Singapore 449876",
        description: "Beachfront playground with ocean views, featuring pirate ship themed play equipment.",
        latitude: 1.3028,
        longitude: 103.9123,
        amenities: '["pirate ship", "slides", "swings", "climbing nets", "beach access"]',
        age_group: "3-12 years",
        opening_hours: "24 hours",
        contact_info: "NParks Hotline: 1800-471-7300"
      },
      {
        name: "Botanic Gardens Children's Garden",
        address: "1 Cluny Rd, Singapore 259569",
        description: "Educational playground within the Singapore Botanic Gardens with nature-themed play equipment.",
        latitude: 1.3151,
        longitude: 103.8162,
        amenities: '["tree house", "water play", "sand pit", "climbing structures", "nature trails"]',
        age_group: "1-12 years",
        opening_hours: "8:30 AM - 7:00 PM",
        contact_info: "Singapore Botanic Gardens: +65 6471 7138"
      },
      {
        name: "Jurong Lake Gardens Playground",
        address: "Yuan Ching Rd, Singapore 618665",
        description: "Modern playground with inclusive play equipment suitable for children of all abilities.",
        latitude: 1.3387,
        longitude: 103.7228,
        amenities: '["inclusive play equipment", "sensory garden", "water play", "climbing structures", "wheelchair accessible"]',
        age_group: "All ages",
        opening_hours: "24 hours",
        contact_info: "NParks Hotline: 1800-471-7300"
      },
      {
        name: "Marina Bay Sands Children's Playground",
        address: "10 Bayfront Ave, Singapore 018956",
        description: "Indoor playground with air-conditioned comfort, perfect for rainy days.",
        latitude: 1.2838,
        longitude: 103.8591,
        amenities: '["indoor play area", "ball pit", "slides", "climbing structures", "air-conditioned"]',
        age_group: "2-10 years",
        opening_hours: "10:00 AM - 10:00 PM",
        contact_info: "Marina Bay Sands: +65 6688 8888"
      }
    ]

    sample_playgrounds.each do |playground_data|
      playground = Playground.find_or_initialize_by(name: playground_data[:name])
      playground.assign_attributes(playground_data)

      if playground.save
        puts "✓ Imported: #{playground.name}"
      else
        puts "✗ Failed to import: #{playground.name} - #{playground.errors.full_messages.join(', ')}"
      end
    end

    puts "\nSample data import completed!"
  end

  desc "Clear all playground data"
  task clear: :environment do
    count = Playground.count
    Playground.destroy_all
    puts "Cleared #{count} playground records"
  end
end
