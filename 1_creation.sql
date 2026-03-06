CREATE TABLE Climber(
   climber_id BIGINT AUTO_INCREMENT,
   first_name VARCHAR(80) NOT NULL,
   last_name VARCHAR(80) NOT NULL,
   email VARCHAR(255) NOT NULL,
   phone VARCHAR(30),
   birth_date DATE,
   account_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   privacy_level SMALLINT NOT NULL DEFAULT 0,
   PRIMARY KEY(climber_id),
   UNIQUE(email)
);

CREATE TABLE `Session`(
   session_id BIGINT AUTO_INCREMENT,
   date_ DATE NOT NULL,
   notes TEXT,
   climber_id BIGINT NOT NULL,
   PRIMARY KEY(session_id),
   FOREIGN KEY(climber_id) REFERENCES Climber(climber_id)
);

CREATE TABLE Styles(
   style_id VARCHAR(50),
   style_name VARCHAR(50) NOT NULL,
   PRIMARY KEY(style_id),
   UNIQUE(style_name)
);

CREATE TABLE Company(
   company_id VARCHAR(50),
   company_name VARCHAR(50) NOT NULL,
   PRIMARY KEY(company_id)
);

CREATE TABLE Gym(
   gym_id BIGINT AUTO_INCREMENT,
   name VARCHAR(150) NOT NULL,
   address VARCHAR(255),
   city VARCHAR(120),
   postal_code VARCHAR(20),
   country VARCHAR(80),
   contact_email VARCHAR(255),
   contact_phone VARCHAR(30),
   company_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(gym_id),
   FOREIGN KEY(company_id) REFERENCES Company(company_id)
);

CREATE TABLE Wall(
   wall_id BIGINT AUTO_INCREMENT,
   name VARCHAR(150) NOT NULL,
   type VARCHAR(80),
   height_meters DECIMAL(5,2),
   gym_id BIGINT NOT NULL,
   PRIMARY KEY(wall_id),
   FOREIGN KEY(gym_id) REFERENCES Gym(gym_id)
);

CREATE TABLE Route(
   route_id BIGINT AUTO_INCREMENT,
   name VARCHAR(200),
   grade_value VARCHAR(20) NOT NULL,
   grade_system VARCHAR(30) NOT NULL,
   color VARCHAR(40),
   tag VARCHAR(50),
   setter_names VARCHAR(255) NOT NULL,
   created_on DATE NOT NULL,
   removed_on DATE,
   wall_id BIGINT NOT NULL,
   PRIMARY KEY(route_id),
   FOREIGN KEY(wall_id) REFERENCES Wall(wall_id)
);

CREATE TABLE Session_route(
   session_id BIGINT,
   route_id BIGINT,
   outcome VARCHAR(30) NOT NULL,
   attempt_count INT NOT NULL DEFAULT 1,
   note TEXT,
   PRIMARY KEY(session_id, route_id),
   FOREIGN KEY(session_id) REFERENCES `Session`(session_id),
   FOREIGN KEY(route_id) REFERENCES Route(route_id)
);

CREATE TABLE subscribe(
   climber_id BIGINT,
   company_id VARCHAR(50),
   type VARCHAR(50),
   start_date DATE,
   end_date DATE,
   status VARCHAR(50),
   subscribtion_id VARCHAR(50),
   PRIMARY KEY(climber_id, company_id),
   FOREIGN KEY(climber_id) REFERENCES Climber(climber_id),
   FOREIGN KEY(company_id) REFERENCES Company(company_id)
);

CREATE TABLE Define(
   route_id BIGINT,
   style_id VARCHAR(50),
   PRIMARY KEY(route_id, style_id),
   FOREIGN KEY(route_id) REFERENCES Route(route_id),
   FOREIGN KEY(style_id) REFERENCES Styles(style_id)
);
