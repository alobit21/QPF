#!/bin/bash
set -e

BASE_URL="http://127.0.0.1:3000"

echo "Logging in as Owner..."
LOGIN_RES=$(curl -s -X POST $BASE_URL/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "owner@spacefinder.com",
    "password": "password123"
  }')

TOKEN=$(echo $LOGIN_RES | grep -o '"access_token":"[^"]*' | grep -o '[^"]*$')

if [ -z "$TOKEN" ]; then
  echo "Failed to get token!"
  exit 1
fi

echo "Fetching offices..."
OFFICES=$(curl -s $BASE_URL/offices)

IDS=$(echo $OFFICES | grep -o '"id":"[^"]*' | grep -o '[^"]*$')

for id in $IDS; do
  echo "Adding slot to office $id..."
  curl -s -X POST $BASE_URL/offices/$id/slots \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{
      "date": "2024-10-25",
      "startTime": "09:00:00",
      "endTime": "11:00:00",
      "roomNumber": "Hot Desk 1"
    }'
  echo ""
  
  curl -s -X POST $BASE_URL/offices/$id/slots \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{
      "date": "2024-10-25",
      "startTime": "13:00:00",
      "endTime": "15:00:00",
      "roomNumber": "Meeting Room A"
    }'
  echo ""
done

echo "Done seeding slots!"
