# Singapore Playground API

A Ruby on Rails API service for collecting and searching playground information in Singapore.

## Features

- Search playgrounds by name, address, or age group
- Location-based search with radius filtering
- RESTful API endpoints
- Docker containerization for easy deployment
- Data import scripts for playground information

## Quick Start with Docker

### Prerequisites

- Docker and Docker Compose installed on your system

### Setup

1. Clone the repository and navigate to the project directory:
```bash
cd playground-api
```

2. Start the application using Docker Compose:
```bash
docker-compose up --build
```

3. In a new terminal, run the database setup:
```bash
docker-compose run --rm web rails db:create db:migrate
```

4. Import sample playground data:
```bash
docker-compose run --rm web rails playgrounds:import_sample
```

The API will be available at `http://localhost:3000`

## API Endpoints

### Get All Playgrounds
```
GET /api/v1/playgrounds
```

Response:
```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "name": "Bishan-Ang Mo Kio Park Playground",
      "address": "1384 Ang Mo Kio Ave 1, Singapore 569932",
      "description": "A large playground with multiple play areas...",
      "coordinates": [1.3691, 103.8454],
      "amenities": ["slides", "swings", "climbing structures"],
      "age_group": "2-12 years",
      "opening_hours": "24 hours",
      "contact_info": "NParks Hotline: 1800-471-7300",
      "created_at": "2024-01-01T00:00:00.000Z",
      "updated_at": "2024-01-01T00:00:00.000Z"
    }
  ]
}
```

### Get Specific Playground
```
GET /api/v1/playgrounds/:id
```

### Search Playgrounds
```
GET /api/v1/playgrounds/search?q=park&age_group=2-12&lat=1.3691&lng=103.8454&radius_km=5
```

Query Parameters:
- `q`: Search query for name or address
- `age_group`: Filter by age group
- `lat`: Latitude for location-based search
- `lng`: Longitude for location-based search
- `radius_km`: Search radius in kilometers (default: 5)

Response:
```json
{
  "status": "success",
  "data": [...],
  "meta": {
    "total_count": 3,
    "query": "park",
    "age_group": "2-12",
    "location": {
      "lat": 1.3691,
      "lng": 103.8454,
      "radius_km": 5
    }
  }
}
```

## Data Import

### Import Sample Data
```bash
docker-compose run --rm web rails playgrounds:import_sample
```

### Import from CSV
Create a CSV file with the following columns:
- name
- address
- description
- latitude
- longitude
- amenities (JSON array as string)
- age_group
- opening_hours
- contact_info

Then run:
```bash
docker-compose run --rm web rails playgrounds:import_csv CSV_FILE=your_file.csv
```

### Clear All Data
```bash
docker-compose run --rm web rails playgrounds:clear
```

## Development

### Running Tests
```bash
docker-compose run --rm web rails test
```

### Rails Console
```bash
docker-compose run --rm web rails console
```

### Database Reset
```bash
docker-compose run --rm web rails db:reset
```

## Database Schema

The `playgrounds` table includes the following fields:
- `id`: Primary key
- `name`: Playground name (required)
- `address`: Playground address (required)
- `description`: Detailed description
- `latitude`: GPS latitude coordinate
- `longitude`: GPS longitude coordinate
- `amenities`: JSON array of available amenities
- `age_group`: Target age group
- `opening_hours`: Operating hours
- `contact_info`: Contact information
- `created_at`: Record creation timestamp
- `updated_at`: Record update timestamp

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.
