JAINAM CAR RENTAL — COMPLETE PHP + MYSQL RENTAL SYSTEM

FEATURES
- Customer registration/login/logout
- Customer booking history
- Admin login/dashboard
- Add/Edit/Hide/Delete vehicles
- Upload exact real vehicle images
- Upload multiple ordered vehicle angle images for 360° viewer
- Cars, Tempo Travellers and large buses
- Booking overlap protection
- Booking status: confirmed/completed/cancelled
- Live road KM using OpenStreetMap Nominatim + OSRM
- MySQL persistence and foreign-key relationships

XAMPP
1. Copy the folder to C:\xampp\htdocs\Jainam_Car_Rental.
2. Start Apache and MySQL.
3. Open phpMyAdmin and import database.sql.
4. If required, edit config.php for MySQL username/password.
5. Visit http://localhost/Jainam_Car_Rental/index.php

ADMIN
Email: admin@jainam.com
Password: Admin@123
Change the password after first login if this is deployed beyond local development.

360 IMAGES
Admin > Cars & Fleet > Edit/Add Vehicle. Upload 6–12 ordered angle images. The public viewer rotates through those frames. This is a frame-based 360 viewer; it does not fabricate a true 3D model.

IMAGES
The database retains the original image URL field from the source project. For exact model images, use Admin > Cars & Fleet to upload the real images you are licensed to use. Uploaded images are stored under uploads/cars.
