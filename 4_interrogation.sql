/* =========================================================
   I. PROJECTIONS / SELECTIONS / SORTING / DISTINCT / MASKS / IN / BETWEEN
   ========================================================= */


/* Q1. List all climbers of Efrei Sport Climbing ordered alphabetically. */
SELECT climber_id, first_name, last_name, email, privacy_level
FROM climber
ORDER BY last_name ASC, first_name ASC;


/* Q2. List distinct route tags used in the association's partner gyms. */
SELECT DISTINCT tag
FROM route
WHERE tag IS NOT NULL
ORDER BY tag ASC;


/* Q3. Find gyms located in cities starting with 'M' or 'P' using a mask. */
SELECT gym_id, name, city, country
FROM gym
WHERE city LIKE 'M%' OR city LIKE 'P%'
ORDER BY city ASC, name ASC;


/* Q4. Show routes using selected grading systems with IN. */
SELECT route_id, name, grade_value, grade_system, wall_id
FROM route
WHERE grade_system IN ('Font', 'French', 'V')
ORDER BY grade_system, grade_value;


/* Q5. Show routes created during spring 2024 using BETWEEN. */
SELECT route_id, name, created_on, removed_on, wall_id
FROM route
WHERE created_on BETWEEN '2024-03-01' AND '2024-05-31'
ORDER BY created_on ASC;


/* =========================================================
   II. AGGREGATE FUNCTIONS / GROUP BY / HAVING
   ========================================================= */


/* Q6. Count how many sessions each climber logged.
   Useful for identifying the most active members of Efrei Sport Climbing. */
SELECT c.climber_id, c.first_name, c.last_name, COUNT(s.session_id) AS session_count
FROM climber c
LEFT JOIN session s ON c.climber_id = s.climber_id
GROUP BY c.climber_id, c.first_name, c.last_name
HAVING COUNT(s.session_id) >= 1
ORDER BY session_count DESC, c.last_name ASC;


/* Q7. Count how many walls each gym contains.
   Useful for selecting gyms for association outings. */
SELECT g.gym_id, g.name, COUNT(w.wall_id) AS wall_count
FROM gym g
LEFT JOIN wall w ON g.gym_id = w.gym_id
GROUP BY g.gym_id, g.name
HAVING COUNT(w.wall_id) >= 1
ORDER BY wall_count DESC, g.name ASC;


/* Q8. Count active subscriptions by company.
   Useful for seeing which partner companies are most used by members. */
SELECT co.company_id, co.company_name, COUNT(su.subscribtion_id) AS active_subscription_count
FROM company co
LEFT JOIN subscribe su
       ON co.company_id = su.company_id
      AND su.status = 'active'
GROUP BY co.company_id, co.company_name
HAVING COUNT(su.subscribtion_id) >= 1
ORDER BY active_subscription_count DESC, co.company_name ASC;


/* Q9. Compute the average number of attempts per route,
   and keep only routes with an average of at least 3 attempts. */
SELECT r.route_id, r.name, ROUND(AVG(sr.attempt_count), 2) AS avg_attempts
FROM route r
JOIN session_route sr ON r.route_id = sr.route_id
GROUP BY r.route_id, r.name
HAVING AVG(sr.attempt_count) >= 3
ORDER BY avg_attempts DESC, r.name ASC;


/* Q10. Count how many logged attempts are associated with each style.
   Useful for understanding what kind of climbing the association practices most. */
SELECT st.style_id, st.style_name, COUNT(*) AS logged_route_count
FROM styles st
JOIN define d ON st.style_id = d.style_id
JOIN session_route sr ON d.route_id = sr.route_id
GROUP BY st.style_id, st.style_name
HAVING COUNT(*) >= 2
ORDER BY logged_route_count DESC, st.style_name ASC;


/* =========================================================
   III. JOINS (INNER, LEFT, MULTIPLE JOINS)
   ========================================================= */


/* Q11. Show each session with the corresponding climber.
   Basic inner join between session and climber. */
SELECT s.session_id, s.date_, c.first_name, c.last_name, s.notes
FROM session s
JOIN climber c ON s.climber_id = c.climber_id
ORDER BY s.date_ ASC, s.session_id ASC;


/* Q12. Show each route with its wall and gym.
   Useful for knowing where each climbed route is located. */
SELECT r.route_id, r.name AS route_name, r.grade_value, r.grade_system,
       w.name AS wall_name, g.name AS gym_name, g.city
FROM route r
JOIN wall w ON r.wall_id = w.wall_id
JOIN gym g ON w.gym_id = g.gym_id
ORDER BY g.name, w.name, r.route_id;


/* Q13. Show subscriptions with climber and company information.
   Useful for membership monitoring by the association board. */
SELECT su.subscribtion_id, su.type, su.status, su.start_date, su.end_date,
       c.first_name, c.last_name, co.company_name
FROM subscribe su
JOIN climber c ON su.climber_id = c.climber_id
JOIN company co ON su.company_id = co.company_id
ORDER BY co.company_name, c.last_name, c.first_name;


/* Q14. List all climbers and their subscription status if they have one.
   LEFT JOIN keeps students with no subscription. */
SELECT c.climber_id, c.first_name, c.last_name,
       su.subscribtion_id, su.type, su.status, su.company_id
FROM climber c
LEFT JOIN subscribe su ON c.climber_id = su.climber_id
ORDER BY c.last_name ASC, c.first_name ASC;


/* Q15. Detailed view of logged route attempts:
   climber + session + route + wall + gym. */
SELECT c.first_name, c.last_name,
       s.session_id, s.date_,
       r.name AS route_name, r.grade_value, r.grade_system,
       w.name AS wall_name,
       g.name AS gym_name,
       sr.outcome, sr.attempt_count
FROM session_route sr
JOIN session s ON sr.session_id = s.session_id
JOIN climber c ON s.climber_id = c.climber_id
JOIN route r ON sr.route_id = r.route_id
JOIN wall w ON r.wall_id = w.wall_id
JOIN gym g ON w.gym_id = g.gym_id
ORDER BY s.date_ ASC, c.last_name ASC, r.name ASC;


/* =========================================================
   IV. NESTED QUERIES (IN, NOT IN, EXISTS, NOT EXISTS, ANY, ALL)
   ========================================================= */


/* Q16. Find climbers who attempted at least one hard French route
   (7a, 7a+, 7b) using IN. */
SELECT DISTINCT c.climber_id, c.first_name, c.last_name
FROM climber c
WHERE c.climber_id IN (
    SELECT s.climber_id
    FROM session s
    JOIN session_route sr ON s.session_id = sr.session_id
    JOIN route r ON sr.route_id = r.route_id
    WHERE r.grade_system = 'French'
      AND r.grade_value IN ('7a', '7a+', '7b')
)
ORDER BY c.last_name, c.first_name;


/* Q17. Find climbers with no subscription at all using NOT IN. */
SELECT c.climber_id, c.first_name, c.last_name
FROM climber c
WHERE c.climber_id NOT IN (
    SELECT su.climber_id
    FROM subscribe su
)
ORDER BY c.last_name, c.first_name;


/* Q18. Find routes that have been topped at least once using EXISTS. */
SELECT r.route_id, r.name, r.grade_value, r.grade_system
FROM route r
WHERE EXISTS (
    SELECT 1
    FROM session_route sr
    WHERE sr.route_id = r.route_id
      AND sr.outcome = 'topped'
)
ORDER BY r.route_id ASC;


/* Q19. Find active routes that have never been logged in any session using NOT EXISTS.
   Useful for spotting routes ignored by association members. */
SELECT r.route_id, r.name, r.grade_value, r.grade_system
FROM route r
WHERE r.removed_on IS NULL
  AND NOT EXISTS (
      SELECT 1
      FROM session_route sr
      WHERE sr.route_id = r.route_id
  )
ORDER BY r.route_id ASC;


/* Q20. Find routes whose average attempt count is greater than or equal to ALL
   routes climbed on auto-belay walls.
   Useful for identifying especially demanding routes compared with easy mileage walls. */
SELECT r.route_id, r.name, ROUND(AVG(sr.attempt_count), 2) AS avg_attempts
FROM route r
JOIN session_route sr ON r.route_id = sr.route_id
GROUP BY r.route_id, r.name
HAVING AVG(sr.attempt_count) >= ALL (
    SELECT AVG(sr2.attempt_count)
    FROM route r2
    JOIN wall w2 ON r2.wall_id = w2.wall_id
    JOIN session_route sr2 ON r2.route_id = sr2.route_id
    WHERE w2.type = 'auto-belay'
    GROUP BY r2.route_id
)
ORDER BY avg_attempts DESC, r.name ASC;


/* Q21. Find routes whose attempt count was equal to ANY session log with 1 attempt.
   Demonstrates the use of ANY. */
SELECT DISTINCT r.route_id, r.name, r.grade_value, r.grade_system
FROM route r
JOIN session_route sr ON r.route_id = sr.route_id
WHERE sr.attempt_count = ANY (
    SELECT sr2.attempt_count
    FROM session_route sr2
    WHERE sr2.attempt_count = 1
)
ORDER BY r.route_id ASC;
