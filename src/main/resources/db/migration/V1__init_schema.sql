-- Insert sample data

-- Cities
INSERT INTO city (name, created_by, created_date, modified_by, modified_date, version)
VALUES 
('Jakarta', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Bandung', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- Cinema
INSERT INTO cinema (name, address, created_by, created_date, modified_by, modified_date, version)
VALUES 
('Cinema 21 Central Park', 'Central Park Mall Lt. 6, Jl. Letjen S. Parman Kav. 28, Jakarta Barat', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Cinema 21 Grand Indonesia', 'Grand Indonesia Mall Lt. 3, Jl. M.H. Thamrin No.1, Jakarta Pusat', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Cinema 21 Paris Van Java', 'Paris Van Java Mall Lt. 3, Jl. Sukajadi No. 131-139, Bandung', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- City Cinema
INSERT INTO city_cinema (city_id, cinema_id, created_by, created_date, modified_by, modified_date, version)
SELECT 
    c.id as city_id,
    ci.id as cinema_id,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM city c
CROSS JOIN cinema ci
WHERE (c.name = 'Jakarta' AND ci.name IN ('Cinema 21 Central Park', 'Cinema 21 Grand Indonesia'))
   OR (c.name = 'Bandung' AND ci.name = 'Cinema 21 Paris Van Java');

-- Studio Layouts
INSERT INTO studio_layout (name, max_rows, max_columns, created_by, created_date, modified_by, modified_date, version)
VALUES 
('Layout 10x20', 10, 20, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Layout 15x30', 15, 30, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Layout 12x25', 12, 25, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- Studios
INSERT INTO studio (name, city_cinema_id, studio_layout_id, created_by, created_date, modified_by, modified_date, version)
SELECT 
    s.name,
    cc.id as city_cinema_id,
    sl.id as studio_layout_id,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM (
    VALUES 
        ('Studio A', 'Layout 10x20'),
        ('Studio B', 'Layout 15x30'),
        ('Studio C', 'Layout 12x25')
) AS s(name, layout_name)
JOIN city_cinema cc ON cc.city_id = (SELECT id FROM city WHERE name = 'Jakarta')
JOIN studio_layout sl ON sl.name = s.layout_name
WHERE cc.cinema_id = (SELECT id FROM cinema WHERE name = 'Cinema 21 Central Park')
UNION ALL
SELECT 
    s.name,
    cc.id as city_cinema_id,
    sl.id as studio_layout_id,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM (
    VALUES 
        ('Studio X', 'Layout 10x20'),
        ('Studio Y', 'Layout 15x30'),
        ('Studio Z', 'Layout 12x25')
) AS s(name, layout_name)
JOIN city_cinema cc ON cc.city_id = (SELECT id FROM city WHERE name = 'Jakarta')
JOIN studio_layout sl ON sl.name = s.layout_name
WHERE cc.cinema_id = (SELECT id FROM cinema WHERE name = 'Cinema 21 Grand Indonesia')
UNION ALL
SELECT 
    s.name,
    cc.id as city_cinema_id,
    sl.id as studio_layout_id,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM (
    VALUES 
        ('Studio 1', 'Layout 10x20'),
        ('Studio 2', 'Layout 15x30'),
        ('Studio 3', 'Layout 12x25')
) AS s(name, layout_name)
JOIN city_cinema cc ON cc.city_id = (SELECT id FROM city WHERE name = 'Bandung')
JOIN studio_layout sl ON sl.name = s.layout_name
WHERE cc.cinema_id = (SELECT id FROM cinema WHERE name = 'Cinema 21 Paris Van Java');

-- Movies
INSERT INTO movie (title, description, duration, synopsis, created_by, created_date, modified_by, modified_date, version)
VALUES 
('The Matrix', 'A computer hacker learns about the true nature of reality', 150, 'A hacker discovers the world is a simulation and leads a rebellion.', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Inception', 'A thief who steals corporate secrets through dream-sharing technology', 148, 'A skilled thief is given a chance at redemption if he can successfully perform inception.', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('The Dark Knight', 'When the menace known as the Joker wreaks havoc on Gotham City', 152, 'Batman faces the Joker, a criminal mastermind who plunges Gotham into chaos.', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Interstellar', 'A team of explorers travel through a wormhole in space', 169, 'Explorers travel through a wormhole in search of a new home for humanity.', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('The Shawshank Redemption', 'Two imprisoned men bond over a number of years', 142, 'Two men form a deep friendship while imprisoned, finding hope and redemption.', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine', 154, 'Stories of crime and redemption intertwine in Los Angeles.', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- Insert seat types
INSERT INTO seat (seat_type, additional_price, created_by, created_date, modified_by, modified_date, version)
VALUES 
('REGULAR', 0, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('COMFORT', 50000, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- Insert studio seats for each studio
-- For studios with Layout 10x20
INSERT INTO studio_seat (studio_id, seat_id, row, number, x_coordinate, y_coordinate, created_by, created_date, modified_by, modified_date, version)
SELECT 
    s.id as studio_id,
    CASE 
        WHEN row_num < 5 THEN 1  -- First 5 rows are REGULAR
        ELSE 2                   -- Last 5 rows are COMFORT
    END as seat_id,
    CASE 
        WHEN row_num < 26 THEN CHR(65 + row_num)
        ELSE CHR(65 + (row_num - 26)/26) || CHR(65 + (row_num - 26)%26)
    END as row,
    col_num + 1 as number,
    col_num as x_coordinate,
    row_num as y_coordinate,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM (
    SELECT 
        a.N as row_num,
        b.N as col_num
    FROM (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
         (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19) b
    WHERE a.N < 10 AND b.N < 20
    ORDER BY a.N, b.N
) numbers
CROSS JOIN studio s
JOIN studio_layout sl ON s.studio_layout_id = sl.id
WHERE sl.name = 'Layout 10x20';

-- For studios with Layout 15x30
INSERT INTO studio_seat (studio_id, seat_id, row, number, x_coordinate, y_coordinate, created_by, created_date, modified_by, modified_date, version)
SELECT 
    s.id as studio_id,
    CASE 
        WHEN row_num < 8 THEN 1  -- First 8 rows are REGULAR
        ELSE 2                   -- Last 7 rows are COMFORT
    END as seat_id,
    CASE 
        WHEN row_num < 26 THEN CHR(65 + row_num)
        ELSE CHR(65 + (row_num - 26)/26) || CHR(65 + (row_num - 26)%26)
    END as row,
    col_num + 1 as number,
    col_num as x_coordinate,
    row_num as y_coordinate,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM (
    SELECT 
        a.N as row_num,
        b.N as col_num
    FROM (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14) a,
         (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29) b
    WHERE a.N < 15 AND b.N < 30
    ORDER BY a.N, b.N
) numbers
CROSS JOIN studio s
JOIN studio_layout sl ON s.studio_layout_id = sl.id
WHERE sl.name = 'Layout 15x30';

-- For studios with Layout 12x25
INSERT INTO studio_seat (studio_id, seat_id, row, number, x_coordinate, y_coordinate, created_by, created_date, modified_by, modified_date, version)
SELECT 
    s.id as studio_id,
    CASE 
        WHEN row_num < 6 THEN 1  -- First 6 rows are REGULAR
        ELSE 2                   -- Last 6 rows are COMFORT
    END as seat_id,
    CASE 
        WHEN row_num < 26 THEN CHR(65 + row_num)
        ELSE CHR(65 + (row_num - 26)/26) || CHR(65 + (row_num - 26)%26)
    END as row,
    col_num + 1 as number,
    col_num as x_coordinate,
    row_num as y_coordinate,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM (
    SELECT 
        a.N as row_num,
        b.N as col_num
    FROM (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) a,
         (SELECT 0 as N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24) b
    WHERE a.N < 12 AND b.N < 25
    ORDER BY a.N, b.N
) numbers
CROSS JOIN studio s
JOIN studio_layout sl ON s.studio_layout_id = sl.id
WHERE sl.name = 'Layout 12x25';

-- Movie Schedules for Studio A (Central Park)
INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    gen_random_uuid() as secure_id,
    m.id as movie_id,
    s.id as studio_id,
    CURRENT_TIMESTAMP + (n.n * INTERVAL '2 hours') as start_time,
    50000 as price,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM movie m
CROSS JOIN studio s
CROSS JOIN (SELECT 1 as n UNION SELECT 2 UNION SELECT 3) n
WHERE s.name = 'Studio A'
AND m.id IN (1, 2, 3)
ORDER BY m.id, n.n;

-- Movie Schedules for Studio B (Central Park)
INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    gen_random_uuid() as secure_id,
    m.id as movie_id,
    s.id as studio_id,
    CURRENT_TIMESTAMP + (n.n * INTERVAL '2 hours') as start_time,
    55000 as price,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM movie m
CROSS JOIN studio s
CROSS JOIN (SELECT 1 as n UNION SELECT 2 UNION SELECT 3) n
WHERE s.name = 'Studio B'
AND m.id IN (4, 5, 6)
ORDER BY m.id, n.n;

-- Movie Schedules for Studio X (Grand Indonesia)
INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    gen_random_uuid() as secure_id,
    m.id as movie_id,
    s.id as studio_id,
    CURRENT_TIMESTAMP + (n.n * INTERVAL '2 hours') as start_time,
    60000 as price,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM movie m
CROSS JOIN studio s
CROSS JOIN (SELECT 1 as n UNION SELECT 2 UNION SELECT 3) n
WHERE s.name = 'Studio X'
AND m.id IN (1, 2, 3)
ORDER BY m.id, n.n;

-- Movie Schedules for Studio Y (Grand Indonesia)
INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    gen_random_uuid() as secure_id,
    m.id as movie_id,
    s.id as studio_id,
    CURRENT_TIMESTAMP + (n.n * INTERVAL '2 hours') as start_time,
    65000 as price,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM movie m
CROSS JOIN studio s
CROSS JOIN (SELECT 1 as n UNION SELECT 2 UNION SELECT 3) n
WHERE s.name = 'Studio Y'
AND m.id IN (4, 5, 6)
ORDER BY m.id, n.n;

-- Movie Schedules for Studio 1 (Paris Van Java)
INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    gen_random_uuid() as secure_id,
    m.id as movie_id,
    s.id as studio_id,
    CURRENT_TIMESTAMP + (n.n * INTERVAL '2 hours') as start_time,
    45000 as price,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM movie m
CROSS JOIN studio s
CROSS JOIN (SELECT 1 as n UNION SELECT 2 UNION SELECT 3) n
WHERE s.name = 'Studio 1'
AND m.id IN (1, 2, 3)
ORDER BY m.id, n.n;

-- Movie Schedules for Studio 2 (Paris Van Java)
INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    gen_random_uuid() as secure_id,
    m.id as movie_id,
    s.id as studio_id,
    CURRENT_TIMESTAMP + (n.n * INTERVAL '2 hours') as start_time,
    50000 as price,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM movie m
CROSS JOIN studio s
CROSS JOIN (SELECT 1 as n UNION SELECT 2 UNION SELECT 3) n
WHERE s.name = 'Studio 2'
AND m.id IN (4, 5, 6)
ORDER BY m.id, n.n;

-- Create movie schedule seats for all schedules
INSERT INTO movie_schedule_seat (secure_id, movie_schedule_id, studio_seat_id, status, price_adjustment, created_by, created_date, modified_by, modified_date, version)
SELECT 
    gen_random_uuid() as secure_id,
    ms.id as movie_schedule_id,
    ss.id as studio_seat_id,
    'AVAILABLE' as status,
    0.0 as price_adjustment,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM movie_schedule ms
JOIN studio s ON ms.studio_id = s.id
JOIN studio_seat ss ON ss.studio_id = s.id;

-- User
INSERT INTO "users" (secure_id, username, password, address, role, created_by, created_date, modified_by, modified_date, version)
VALUES 
('550e8400-e29b-41d4-a716-446655440000', 'gen', 'password', 'Jakarta, Indonesia', 'USER', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('550e8400-e29b-41d4-a716-446655440001', 'admin', 'password', 'Jakarta, Indonesia', 'ADMIN', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- Add movie_schedule entries for today and the next 3 days for each studio and movie
DO $$
DECLARE
    d integer;
    m_id integer;
    s_id integer;
    base_date date := CURRENT_DATE;
BEGIN
    FOR d IN 0..3 LOOP
        FOR m_id IN (SELECT id FROM movie) LOOP
            FOR s_id IN (SELECT id FROM studio) LOOP
                INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
                VALUES (
                    gen_random_uuid(),
                    m_id,
                    s_id,
                    (base_date + d) + INTERVAL '14 hours',
                    50000 + (d * 5000),
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    0
                );
                INSERT INTO movie_schedule (secure_id, movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
                VALUES (
                    gen_random_uuid(),
                    m_id,
                    s_id,
                    (base_date + d) + INTERVAL '17 hours',
                    50000 + (d * 5000),
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    0
                );
            END LOOP;
        END LOOP;
    END LOOP;
END $$; 