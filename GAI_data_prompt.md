Provide the insertion queries used to populate the database, whose relational model is as follows:

Climber(climber_id, first_name, last_name, email, phone, birth_date, account_created_at, privacy_level)
PK: climber_id

Session(session_id, date_, notes, #climber_id)
PK: session_id
FK: climber_id → Climber(climber_id)

Styles(style_id, style_name)
PK: style_id

Company(company_id, company_name)
PK: company_id

Gym(gym_id, name, address, city, postal_code, country, contact_email, contact_phone, #company_id)
PK: gym_id
FK: company_id → Company(company_id)

Wall(wall_id, name, type, height_meters, #gym_id)
PK: wall_id
FK: gym_id → Gym(gym_id)

Route(route_id, name, grade_value, grade_system, color, tag, setter_names, created_on, removed_on, #wall_id)
PK: route_id
FK: wall_id → Wall(wall_id)

Session_route(#session_id, #route_id, outcome, attempt_count, note)
PK: (session_id, route_id)
FK: session_id → Session(session_id)
FK: route_id → Route(route_id)

Subscribe(subscribtion_id, type, start_date, end_date, status, #climber_id, #company_id)
PK: subscribtion_id
FK: climber_id → Climber(climber_id)
FK: company_id → Company(company_id)

Define(#route_id, #style_id)
PK: (route_id, style_id)
FK: route_id → Route(route_id)
FK: style_id → Styles(style_id)

There must be:
- 8 rows for the Company table
- 12 rows for the Gym table
- 24 rows for the Wall table
- 40 rows for the Route table
- 10 rows for the Styles table
- 30 rows for the Climber table
- 30 rows for the Session table
- at least 50 rows for the Session_route table
- at least 20 rows for the Subscribe table
- at least 40 rows for the Define table

The inserted data must be coherent with the domain of indoor climbing gyms and route tracking.

Use realistic values:
- companies must look like real climbing-gym brands or local operators
- gyms must be located in different cities and countries
- walls must have realistic names/zones and wall types
- routes must have plausible climbing grades, colors, tags and opening/removal dates
- climbers’ first and last names must refer to various origins and be mixed
- sessions must be realistic and linked to existing climbers
- session attempts must be linked to existing sessions and routes
- subscriptions must be linked to existing climbers and companies

Foreign keys must refer to existing primary keys: provide the lines starting with filling in the tables in which there are no foreign keys, then the tables in which the foreign keys refer to primary keys in tables that have already been filled in.

The data must comply with the following validation constraints:

- Climber.email must be unique
- Climber.privacy_level must be in (0, 1, 2, 3)
- Climber.birth_date must be NULL or <= CURRENT_DATE
- Climber.account_created_at must be <= CURRENT_TIMESTAMP

- Gym.company_id must reference an existing Company
- Gym name should be unique per company

- Wall.type must be one of:
  ('boulder', 'lead', 'auto-belay', 'training board')
- Wall.height_meters must be NULL or > 0
- Wall name must be unique inside a gym

- Route.wall_id must reference an existing Wall
- Route.grade_value must not be blank
- Route.grade_system must be one of:
  ('Font', 'V', 'YDS', 'French')
- Route.setter_names must not be blank
- Route.removed_on must be NULL or >= Route.created_on

- Session.climber_id must reference an existing Climber

- Session_route.session_id must reference an existing Session
- Session_route.route_id must reference an existing Route
- Session_route.outcome must be one of:
  ('topped', 'attempted')
- Session_route.attempt_count must be >= 1

- Subscribe.climber_id must reference an existing Climber
- Subscribe.company_id must reference an existing Company
- Subscribe.type must be one of:
  ('day pass', 'monthly', 'annual', 'student')
- Subscribe.status must be one of:
  ('active', 'expired', 'cancelled', 'suspended')
- Subscribe.end_date must be NULL or >= Subscribe.start_date
- At most one active subscription can exist for the same climber and company

- Define.route_id must reference an existing Route
- Define.style_id must reference an existing Styles

Additional requirements:
- use explicit INSERT INTO ... VALUES statements
- do not use placeholders
- do not omit IDs
- make all inserted IDs consistent and reusable by foreign keys
- produce the result as a single SQL script ready to be executed
- order the INSERT statements correctly to respect referential integrity
- do not include explanations, only the SQL script
