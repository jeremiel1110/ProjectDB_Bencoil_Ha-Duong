-- WALL
ALTER TABLE Wall
ADD CONSTRAINT chk_wall_type
CHECK (type IN ('boulder', 'lead', 'auto-belay', 'training board'));

ALTER TABLE Wall
ADD CONSTRAINT chk_wall_height
CHECK (height_meters IS NULL OR height_meters > 0);

ALTER TABLE Wall
ADD CONSTRAINT uq_wall_name_per_gym
UNIQUE (gym_id, name);

-- ROUTE
-- removed_on is already nullable, so no ALTER needed

ALTER TABLE Route
ADD CONSTRAINT chk_route_dates
CHECK (removed_on IS NULL OR removed_on >= created_on);

ALTER TABLE Route
ADD CONSTRAINT chk_route_grade_system
CHECK (grade_system IN ('Font', 'V', 'YDS', 'French'));

ALTER TABLE Route
ADD CONSTRAINT chk_route_grade_value_not_blank
CHECK (TRIM(grade_value) <> '');

ALTER TABLE Route
ADD CONSTRAINT chk_route_setter_names_not_blank
CHECK (TRIM(setter_names) <> '');

-- CLIMBER
ALTER TABLE Climber
ADD CONSTRAINT chk_climber_privacy_level
CHECK (privacy_level IN (0, 1, 2, 3));

ALTER TABLE Climber
ADD CONSTRAINT chk_climber_birth_date
CHECK (birth_date IS NULL OR birth_date <= CURRENT_DATE);

ALTER TABLE Climber
ADD CONSTRAINT chk_climber_email_format
CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$');

-- SESSION_ROUTE
ALTER TABLE Session_route
ADD CONSTRAINT chk_session_route_outcome
CHECK (outcome IN ('topped', 'attempted'));

ALTER TABLE Session_route
ADD CONSTRAINT chk_session_route_attempt_count
CHECK (attempt_count >= 1);

-- SUBSCRIBE
ALTER TABLE subscribe
ADD CONSTRAINT chk_subscribe_type
CHECK (type IN ('day pass', 'monthly', 'annual', 'student'));

ALTER TABLE subscribe
ADD CONSTRAINT chk_subscribe_status
CHECK (status IN ('active', 'expired', 'cancelled', 'suspended'));

ALTER TABLE subscribe
ADD CONSTRAINT chk_subscribe_dates
CHECK (end_date IS NULL OR end_date >= start_date);
