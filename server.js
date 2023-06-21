const express = require('express');
const app = express();

const canteenLocations = {
    'Canteen Zubair': { lat: 123.456, lng: 789.012 },
    'Canteen Ali': { lat: 345.678, lng: 901.234 },
    'Canteen Siddiq': { lat: 312.678, lng: 231.234 },
    'Canteen Farouq':{ lat: 412.678, lng: 231.234 },
    'Canteen Maryam':{ lat: 512.678, lng: 231.234 },
    'Canteen Asia': { lat: 612.678, lng: 231.234 },
    'Canteen Hafsa': { lat: 112.678, lng: 231.234 },
    'Canteen Halima': { lat: 12.678, lng: 231.234 },
    // Add more canteen locations
  };
  app.get('', (req, res) => {
    // Return the canteen locations as JSON
    res.json(canteenLocations);
  });
  const port = 3000; // Choose a port number for your server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
