#!/bin/bash

echo "Starting Rails server..."
rails s &

cd client 

npm ci

echo "Starting front-end server..."
npm run dev

