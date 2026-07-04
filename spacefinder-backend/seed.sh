#!/bin/bash
set -e

BASE_URL="http://127.0.0.1:3000"

echo "Registering Owner User..."
USER_RES=$(curl -s -X POST $BASE_URL/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "owner@spacefinder.com",
    "password": "password123",
    "firstName": "Alex",
    "lastName": "Owner",
    "role": "owner"
  }')

echo "Logging in..."
LOGIN_RES=$(curl -s -X POST $BASE_URL/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "owner@spacefinder.com",
    "password": "password123"
  }')

TOKEN=$(echo $LOGIN_RES | grep -o '"access_token":"[^"]*' | grep -o '[^"]*$')

echo "Got token: $TOKEN"

echo "Creating Dodoma Tech Hub..."
curl -s -X POST $BASE_URL/offices \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Dodoma Tech Hub",
    "description": "Modern coworking space in the heart of Dodoma with high-speed internet and ergonomic seating.",
    "address": "123 Tech Avenue",
    "city": "Dodoma",
    "latitude": -6.162959,
    "longitude": 35.751607,
    "pricePerHour": 8.00,
    "size": 500,
    "availableRooms": 4,
    "images": ["https://storage.googleapis.com/banani-generated-images/generated-images/41453429-4199-4d32-9dbd-47e5fe4a45ce.jpg"]
  }'

echo -e "\nCreating Creative Space Arusha..."
curl -s -X POST $BASE_URL/offices \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Creative Space Arusha",
    "description": "Inspiring workspace near Mount Meru, perfect for designers and remote workers.",
    "address": "45 Art Street",
    "city": "Arusha",
    "latitude": -3.3722,
    "longitude": 36.6828,
    "pricePerHour": 10.00,
    "size": 300,
    "availableRooms": 3,
    "images": ["https://storage.googleapis.com/banani-generated-images/generated-images/b755aa9c-6ac4-493e-9a6f-26d9b49633f1.jpg"]
  }'

echo -e "\nCreating Dar Hub Central..."
curl -s -X POST $BASE_URL/offices \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Dar Hub Central",
    "description": "Premium corporate coworking space in Dar es Salaam business district.",
    "address": "789 Corporate Blvd",
    "city": "Dar es Salaam",
    "latitude": -6.8235,
    "longitude": 39.2695,
    "pricePerHour": 12.00,
    "size": 1200,
    "availableRooms": 10,
    "images": ["https://storage.googleapis.com/banani-generated-images/generated-images/6f7ac066-4842-43aa-a3e1-7495bca6b0b2.jpg"]
  }'

echo -e "\nCreating InnoSpace Mwanza..."
curl -s -X POST $BASE_URL/offices \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "InnoSpace Mwanza",
    "description": "Lake view coworking space offering a peaceful environment.",
    "address": "12 Lake Road",
    "city": "Mwanza",
    "latitude": -2.5165,
    "longitude": 32.9000,
    "pricePerHour": 7.00,
    "size": 400,
    "availableRooms": 2,
    "images": ["https://storage.googleapis.com/banani-generated-images/generated-images/abc459d2-e1c8-448e-9414-b57e520658f1.jpg"]
  }'

echo -e "\nCreating Kilimanjaro Works..."
curl -s -X POST $BASE_URL/offices \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Kilimanjaro Works",
    "description": "Cozy space for startups in Moshi.",
    "address": "5 Mountain View",
    "city": "Moshi",
    "latitude": -3.3344,
    "longitude": 37.3400,
    "pricePerHour": 9.00,
    "size": 350,
    "availableRooms": 5,
    "images": ["https://storage.googleapis.com/banani-generated-images/generated-images/f984e8e9-7943-487a-8a85-ee0d5f1ef74e.jpg"]
  }'

echo -e "\nDone!"
