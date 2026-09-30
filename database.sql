CREATE DATABASE IF NOT EXISTS jainam_car_rental CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE jainam_car_rental;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS feedback, bookings, car_images, cars, users;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE users (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(160) NOT NULL UNIQUE,
 phone VARCHAR(30) NULL,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('customer','admin') NOT NULL DEFAULT 'customer',
 active TINYINT(1) NOT NULL DEFAULT 1,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE cars (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 budget ENUM('low','medium','high') NOT NULL,
 seats INT NOT NULL,
 name VARCHAR(150) NOT NULL,
 type VARCHAR(100) NOT NULL,
 day_price DECIMAL(10,2) NOT NULL,
 km_price DECIMAL(10,2) NOT NULL,
 transmission VARCHAR(100) NOT NULL,
 fuel VARCHAR(100) NOT NULL,
 ac VARCHAR(100) NOT NULL,
 luggage VARCHAR(150) NOT NULL,
 model_year VARCHAR(10) NOT NULL,
 image_url TEXT NULL,
 active TINYINT(1) NOT NULL DEFAULT 1,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_cars_filter (budget,seats,active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE car_images (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 car_id INT UNSIGNED NOT NULL,
 image_url TEXT NOT NULL,
 angle_no TINYINT UNSIGNED NOT NULL DEFAULT 0,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_image_car FOREIGN KEY (car_id) REFERENCES cars(id) ON UPDATE CASCADE ON DELETE CASCADE,
 INDEX idx_image_car_angle(car_id,angle_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE bookings (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 booking_code VARCHAR(30) NOT NULL UNIQUE,
 car_id INT UNSIGNED NOT NULL,
 customer_id INT UNSIGNED NULL,
 customer_name VARCHAR(120) NOT NULL,
 customer_phone VARCHAR(30) NOT NULL,
 customer_email VARCHAR(160) NULL,
 from_city VARCHAR(120) NOT NULL,
 to_city VARCHAR(120) NOT NULL,
 pickup_date DATE NOT NULL,
 return_date DATE NOT NULL,
 total_km DECIMAL(10,2) NOT NULL,
 days INT NOT NULL,
 day_charge DECIMAL(12,2) NOT NULL,
 km_charge DECIMAL(12,2) NOT NULL,
 total_amount DECIMAL(12,2) NOT NULL,
 status ENUM('confirmed','cancelled','completed') NOT NULL DEFAULT 'confirmed',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_booking_car FOREIGN KEY (car_id) REFERENCES cars(id) ON UPDATE CASCADE ON DELETE RESTRICT,
 CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL,
 INDEX idx_booking_dates (car_id,pickup_date,return_date,status),
 INDEX idx_booking_customer(customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE feedback (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 booking_id BIGINT UNSIGNED NULL,
 customer_id INT UNSIGNED NULL,
 rating TINYINT UNSIGNED NULL,
 feedback_text TEXT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_feedback_booking FOREIGN KEY (booking_id) REFERENCES bookings(id) ON UPDATE CASCADE ON DELETE SET NULL,
 CONSTRAINT fk_feedback_customer FOREIGN KEY (customer_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO users(name,email,phone,password_hash,role) VALUES
('Jainam Admin','admin@jainam.com','9999999999','$2y$12$nkiP1hceajh.O34lSS9tTuJRnXx517PtsZNthNiCgEAsFzPvPr4La','admin');

INSERT INTO cars (budget,seats,name,type,day_price,km_price,transmission,fuel,ac,luggage,model_year,image_url) VALUES
('low',7,'Maruti Suzuki Ertiga','Family MPV',2999,12,'Manual / Automatic','Petrol / CNG','Automatic AC','Large family boot','2025','https://tse1.mm.bing.net/th?q=Maruti%20Suzuki%20Ertiga%202025%20car%20front%20official'),
('low',7,'Maruti Suzuki Eeco','Practical MPV',2499,10,'Manual','Petrol / CNG','Manual AC','Large cargo area','2025','https://tse1.mm.bing.net/th?q=Maruti%20Suzuki%20Eeco%202025%20car%20front%20official'),
('low',7,'Nissan Gravite','Family MPV',2699,11,'Manual / Automatic','Petrol','AC','Family luggage','2025','https://tse1.mm.bing.net/th?q=Nissan%20Gravite%202025%20car%20front%20official'),
('low',7,'Renault Triber','Compact MPV',2799,11,'Manual / Automatic','Petrol','Automatic AC','Flexible boot','2025','https://tse1.mm.bing.net/th?q=Renault%20Triber%202025%20car%20front%20official'),
('low',5,'Tata Tiago','Hatchback',2199,9,'Manual / AMT','Petrol / CNG','AC','Compact boot','2025','https://tse1.mm.bing.net/th?q=Tata%20Tiago%202025%20car%20front%20official'),
('low',5,'Maruti Suzuki Wagon R','Hatchback',2299,9,'Manual / AMT','Petrol / CNG','AC','Good city boot','2025','https://tse1.mm.bing.net/th?q=Maruti%20Suzuki%20Wagon%20R%202025%20car%20front%20official'),
('low',5,'Hyundai Grand i10 Nios','Hatchback',2399,9,'Manual / AMT','Petrol / CNG','Automatic AC','Compact boot','2025','https://tse1.mm.bing.net/th?q=Hyundai%20Grand%20i10%20Nios%202025%20car%20front%20official'),
('low',5,'Maruti Suzuki Celerio','Hatchback',2399,9,'Manual / AMT','Petrol / CNG','AC','Compact boot','2025','https://tse1.mm.bing.net/th?q=Maruti%20Suzuki%20Celerio%202025%20car%20front%20official'),
('low',7,'Toyota Rumion','Family MPV',3299,13,'Manual / Automatic','Petrol / CNG','Automatic AC','Large family boot','2025','https://tse1.mm.bing.net/th?q=Toyota%20Rumion%202025%20car%20front%20official'),
('low',7,'Mahindra Bolero','Utility SUV',2999,12,'Manual','Diesel','Manual AC','Large utility space','2025','https://tse1.mm.bing.net/th?q=Mahindra%20Bolero%202025%20car%20front%20official'),
('medium',2,'PMV EaS E','Electric City Car',2799,10,'Automatic','Electric','AC','City luggage','2025','https://tse1.mm.bing.net/th?q=PMV%20EaS%20E%202025%20car%20front%20official'),
('medium',5,'Maruti Suzuki Baleno','Premium Hatchback',3199,12,'Manual / AMT','Petrol / CNG','Automatic AC','Comfortable boot','2025','https://tse1.mm.bing.net/th?q=Maruti%20Suzuki%20Baleno%202025%20car%20front%20official'),
('medium',5,'Mahindra XUV 3XO','Compact SUV',3699,14,'Manual / Automatic','Petrol / Diesel','Automatic AC','SUV boot','2025','https://tse1.mm.bing.net/th?q=Mahindra%20XUV%203XO%202025%20car%20front%20official'),
('medium',5,'Maruti Suzuki Swift','Hatchback',2999,11,'Manual / AMT','Petrol','AC','Compact boot','2025','https://tse1.mm.bing.net/th?q=Maruti%20Suzuki%20Swift%202025%20car%20front%20official'),
('medium',7,'Kia Carens','Family MPV',4499,17,'Manual / Automatic','Petrol / Diesel','Multi-zone AC','Large family boot','2025','https://tse1.mm.bing.net/th?q=Kia%20Carens%202025%20car%20front%20official'),
('medium',7,'Kia Carens Clavis','Premium Family MPV',4999,18,'Manual / Automatic','Petrol / Diesel','Multi-zone AC','Large family boot','2025','https://tse1.mm.bing.net/th?q=Kia%20Carens%20Clavis%202025%20car%20front%20official'),
('medium',7,'Toyota Fortuner','Premium SUV',6999,22,'Manual / Automatic','Petrol / Diesel','Automatic AC','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Toyota%20Fortuner%202025%20car%20front%20official'),
('medium',5,'Hyundai Creta','Mid-size SUV',3899,15,'Manual / Automatic','Petrol / Diesel','Automatic Climate','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Hyundai%20Creta%202025%20car%20front%20official'),
('medium',5,'Kia Seltos','Mid-size SUV',3999,16,'Manual / Automatic','Petrol / Diesel','Automatic Climate','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Kia%20Seltos%202025%20car%20front%20official'),
('medium',5,'Tata Nexon','Compact SUV',3299,13,'Manual / AMT','Petrol / Diesel / CNG','Automatic Climate','SUV boot','2025','https://tse1.mm.bing.net/th?q=Tata%20Nexon%202025%20car%20front%20official'),
('medium',5,'Toyota Urban Cruiser Hyryder','Hybrid SUV',4499,18,'Manual / Automatic','Petrol / Hybrid','Automatic Climate','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Toyota%20Urban%20Cruiser%20Hyryder%202025%20car%20front%20official'),
('medium',7,'Mahindra Scorpio N','Premium SUV',5499,20,'Manual / Automatic','Petrol / Diesel','Automatic Climate','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Mahindra%20Scorpio%20N%202025%20car%20front%20official'),
('medium',7,'Hyundai Alcazar','Premium Family SUV',5299,19,'Manual / Automatic','Petrol / Diesel','Automatic Climate','Large family boot','2025','https://tse1.mm.bing.net/th?q=Hyundai%20Alcazar%202025%20car%20front%20official'),
('medium',9,'Force Traveller Maharaja','Luxury Tempo Traveller',5999,24,'Manual','Diesel','Automatic AC','Large luggage space','2025','https://tse1.mm.bing.net/th?q=Force%20Traveller%20Maharaja%202025%20car%20front%20official'),
('medium',12,'Force Traveller 12 Seater','AC Tempo Traveller',6499,26,'Manual','Diesel','Automatic AC','Large luggage space','2025','https://tse1.mm.bing.net/th?q=Force%20Traveller%2012%20Seater%202025%20car%20front%20official'),
('medium',17,'Force Traveller 17 Seater','AC Tempo Traveller',7499,28,'Manual','Diesel','Automatic AC','Very large luggage space','2025','https://tse1.mm.bing.net/th?q=Force%20Traveller%2017%20Seater%202025%20car%20front%20official'),
('medium',17,'Force Urbania 17 Seater','Premium Luxury Van',8999,35,'Manual','Diesel','Automatic Climate','Large luggage space','2025','https://tse1.mm.bing.net/th?q=Force%20Urbania%2017%20Seater%202025%20car%20front%20official'),
('medium',20,'Force Maharaja 20 Seater','Luxury Tempo Traveller',8499,30,'Manual','Diesel','Automatic AC','Very large luggage space','2025','https://tse1.mm.bing.net/th?q=Force%20Maharaja%2020%20Seater%202025%20car%20front%20official'),
('medium',26,'Force Traveller 26 Seater','Large Tempo Traveller',9999,34,'Manual','Diesel','Automatic AC','Extra large luggage space','2025','https://tse1.mm.bing.net/th?q=Force%20Traveller%2026%20Seater%202025%20car%20front%20official'),
('high',35,'BharatBenz 35 Seater','Luxury AC Mini Bus',12999,40,'Manual','Diesel','Automatic AC','Large luggage compartment','2025','https://tse1.mm.bing.net/th?q=BharatBenz%2035%20Seater%202025%20car%20front%20official'),
('high',40,'Eicher 40 Seater Coach','AC Tourist Coach',13999,44,'Manual','Diesel','Automatic AC','Large luggage compartment','2025','https://tse1.mm.bing.net/th?q=Eicher%2040%20Seater%20Coach%202025%20car%20front%20official'),
('high',45,'Volvo 45 Seater Coach','Luxury Volvo AC Bus',18999,50,'Automatic','Diesel','Automatic Climate','Large luggage compartment','2025','https://tse1.mm.bing.net/th?q=Volvo%2045%20Seater%20Coach%202025%20car%20front%20official'),
('high',45,'BharatBenz 45 Seater','Luxury AC Bus',16999,47,'Manual','Diesel','Automatic AC','Large luggage compartment','2025','https://tse1.mm.bing.net/th?q=BharatBenz%2045%20Seater%202025%20car%20front%20official'),
('high',45,'Ashok Leyland 45 Seater','Luxury AC Bus',15999,45,'Manual','Diesel','Automatic AC','Large luggage compartment','2025','https://tse1.mm.bing.net/th?q=Ashok%20Leyland%2045%20Seater%202025%20car%20front%20official'),
('high',49,'Volvo B7R 49 Seater','Premium Volvo AC Coach',19999,52,'Automatic','Diesel','Automatic Climate','Extra large luggage compartment','2025','https://tse1.mm.bing.net/th?q=Volvo%20B7R%2049%20Seater%202025%20car%20front%20official'),
('high',55,'Tata Starbus 55 Seater','Large AC Bus',17999,50,'Manual','Diesel','Automatic AC','Very large luggage compartment','2025','https://tse1.mm.bing.net/th?q=Tata%20Starbus%2055%20Seater%202025%20car%20front%20official'),
('high',2,'MG Cyberster','Electric Roadster',18999,55,'Automatic','Electric','Automatic Climate','Sports-car boot','2026','https://tse1.mm.bing.net/th?q=MG%20Cyberster%202025%20car%20front%20official'),
('high',2,'BMW Z4','Luxury Roadster',16999,50,'Automatic','Petrol','Automatic Climate','Roadster boot','2025','https://tse1.mm.bing.net/th?q=BMW%20Z4%202025%20car%20front%20official'),
('high',2,'Porsche 718','Sports Car',21999,65,'Automatic / Manual','Petrol','Automatic Climate','Sports-car storage','2025','https://tse1.mm.bing.net/th?q=Porsche%20718%202025%20car%20front%20official'),
('high',2,'Lamborghini Revuelto','Luxury Supercar',49999,100,'Automatic','Petrol / Hybrid','Automatic Climate','Supercar storage','2025','https://tse1.mm.bing.net/th?q=Lamborghini%20Revuelto%202025%20car%20front%20official'),
('high',2,'Aston Martin Vantage','Luxury Sports Car',29999,80,'Automatic','Petrol','Automatic Climate','Sports-car boot','2025','https://tse1.mm.bing.net/th?q=Aston%20Martin%20Vantage%202025%20car%20front%20official'),
('high',2,'Lotus Emira','Luxury Sports Car',24999,75,'Automatic / Manual','Petrol','Automatic Climate','Sports-car storage','2025','https://tse1.mm.bing.net/th?q=Lotus%20Emira%202025%20car%20front%20official'),
('high',2,'Mazda MX-5 Miata','Convertible Roadster',13999,48,'Manual / Automatic','Petrol','Automatic Climate','Roadster boot','2025','https://tse1.mm.bing.net/th?q=Mazda%20MX-5%20Miata%202025%20car%20front%20official'),
('high',2,'Toyota GR86','Sports Coupe',12999,45,'Manual / Automatic','Petrol','Automatic Climate','Sports-car storage','2025','https://tse1.mm.bing.net/th?q=Toyota%20GR86%202025%20car%20front%20official'),
('high',5,'Mahindra BE 6','Electric SUV',7499,25,'Automatic','Electric','Automatic Climate','SUV boot','2025','https://tse1.mm.bing.net/th?q=Mahindra%20BE%206%202025%20car%20front%20official'),
('high',5,'Jaguar F-Pace','Luxury SUV',10999,35,'Automatic','Petrol / Diesel','Automatic Climate','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Jaguar%20F-Pace%202025%20car%20front%20official'),
('high',5,'Kia Sorento','Premium SUV',9499,30,'Automatic','Petrol / Diesel / Hybrid','Automatic Climate','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Kia%20Sorento%202025%20car%20front%20official'),
('high',5,'BMW X1','Luxury SUV',8999,32,'Automatic','Petrol / Diesel','Automatic Climate','SUV boot','2025','https://tse1.mm.bing.net/th?q=BMW%20X1%202025%20car%20front%20official'),
('high',7,'Toyota Vellfire','Luxury MPV',14999,45,'Automatic','Hybrid','Multi-zone Climate','Premium luggage space','2025','https://tse1.mm.bing.net/th?q=Toyota%20Vellfire%202025%20car%20front%20official'),
('high',7,'Kia Carnival','Luxury MPV',11999,38,'Automatic','Diesel','Multi-zone AC','Large luggage space','2025','https://tse1.mm.bing.net/th?q=Kia%20Carnival%202025%20car%20front%20official'),
('high',7,'Mercedes-Benz V-Class Extra LWB','Luxury Van',16999,48,'Automatic','Diesel','Automatic Climate','Very large luggage space','2025','https://tse1.mm.bing.net/th?q=Mercedes-Benz%20V-Class%20Extra%20LWB%202025%20car%20front%20official'),
('high',7,'Skoda Peaq','Premium SUV',9999,33,'Automatic','Petrol / Electric','Automatic Climate','Large SUV boot','2026','https://tse1.mm.bing.net/th?q=Skoda%20Peaq%202025%20car%20front%20official'),
('high',5,'Volkswagen Tayron Life','Premium SUV',8999,31,'Automatic','Petrol','Automatic Climate','Large SUV boot','2026','https://tse1.mm.bing.net/th?q=Volkswagen%20Tayron%20Life%202025%20car%20front%20official'),
('high',5,'Toyota Camry','Premium Sedan',8499,30,'Automatic','Petrol / Hybrid','Automatic Climate','Large sedan boot','2025','https://tse1.mm.bing.net/th?q=Toyota%20Camry%202025%20car%20front%20official'),
('high',7,'Toyota Innova HyCross','Premium Hybrid MPV',8499,27,'Automatic','Petrol / Hybrid','Multi-zone Climate','Large family boot','2025','https://tse1.mm.bing.net/th?q=Toyota%20Innova%20HyCross%202025%20car%20front%20official'),
('high',7,'Mahindra XUV700','Premium SUV',7499,24,'Manual / Automatic','Petrol / Diesel','Dual-zone Climate','Large SUV boot','2025','https://tse1.mm.bing.net/th?q=Mahindra%20XUV700%202025%20car%20front%20official'),
('high',7,'Jeep Meridian','Premium 4x4 SUV',8999,29,'Automatic','Diesel','Dual-zone Climate','Large SUV boot','2026','https://tse1.mm.bing.net/th?q=Jeep%20Meridian%202025%20car%20front%20official'),
('high',7,'MG Gloster','Luxury SUV',10499,34,'Automatic','Diesel','Multi-zone Climate','Large SUV boot','2026','https://tse1.mm.bing.net/th?q=MG%20Gloster%202025%20car%20front%20official');
