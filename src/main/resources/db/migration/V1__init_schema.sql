-- Insert sample data

-- Cities
INSERT INTO city (name, created_by, created_date, modified_by, modified_date, version)
VALUES 
('Jakarta', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Bandung', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- Cinema
INSERT INTO cinema (name, created_by, created_date, modified_by, modified_date, version)
VALUES 
('Cinema 21', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

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
WHERE c.name IN ('Jakarta', 'Bandung')
AND ci.name = 'Cinema 21';

-- Studio Layouts
INSERT INTO studio_layout (name, max_rows, max_columns, created_by, created_date, modified_by, modified_date, version)
VALUES 
('Layout 10x20', 10, 20, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Layout 15x30', 15, 30, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

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
        ('Studio 1', 'Layout 10x20'),
        ('Studio 2', 'Layout 15x30')
) AS s(name, layout_name)
JOIN city_cinema cc ON cc.city_id = (SELECT id FROM city WHERE name = 'Jakarta')
JOIN studio_layout sl ON sl.name = s.layout_name;

-- Movies
INSERT INTO movie (title, description, duration, created_by, created_date, modified_by, modified_date, version)
VALUES 
('The Matrix', 'A computer hacker learns about the true nature of reality', 150, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Inception', 'A thief who steals corporate secrets through dream-sharing technology', 148, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('The Dark Knight', 'When the menace known as the Joker wreaks havoc on Gotham City', 152, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('Interstellar', 'A team of explorers travel through a wormhole in space', 169, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
('The Shawshank Redemption', 'Two imprisoned men bond over a number of years', 142, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- Seats for Studio 1 (10x20)
INSERT INTO seat (row, number, seat_type, additional_price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    CASE 
        WHEN row_num < 26 THEN CHR(65 + row_num)
        ELSE CHR(65 + (row_num - 26)/26) || CHR(65 + (row_num - 26)%26)
    END as row,
    col_num + 1 as number,
    'REGULAR' as seat_type,
    0 as additional_price,
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
) numbers;

-- Seats for Studio 2 (15x30)
INSERT INTO seat (row, number, seat_type, additional_price, created_by, created_date, modified_by, modified_date, version)
SELECT 
    CASE 
        WHEN row_num < 26 THEN CHR(65 + row_num)
        ELSE CHR(65 + (row_num - 26)/26) || CHR(65 + (row_num - 26)%26)
    END as row,
    col_num + 1 as number,
    'REGULAR' as seat_type,
    0 as additional_price,
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
) numbers;

-- Studio Seats for Studio 1
INSERT INTO studio_seat (studio_id, seat_id, x_coordinate, y_coordinate, created_by, created_date, modified_by, modified_date, version)
SELECT 
    1 as studio_id,
    id as seat_id,
    (number - 1) as x_coordinate,
    (ASCII(row) - ASCII('A')) as y_coordinate,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM seat
WHERE id <= 200;

-- Studio Seats for Studio 2
INSERT INTO studio_seat (studio_id, seat_id, x_coordinate, y_coordinate, created_by, created_date, modified_by, modified_date, version)
SELECT 
    2 as studio_id,
    id as seat_id,
    (number - 1) as x_coordinate,
    (ASCII(row) - ASCII('A')) as y_coordinate,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM seat
WHERE id > 200;

-- Movie Schedules
INSERT INTO movie_schedule (movie_id, studio_id, start_time, price, created_by, created_date, modified_by, modified_date, version)
VALUES 
(1, 1, CURRENT_TIMESTAMP + INTERVAL '2 hours', 50000, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0),
(2, 2, CURRENT_TIMESTAMP + INTERVAL '4 hours', 55000, 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0);

-- For Studio 1's movie schedule
INSERT INTO movie_schedule_seat (movie_schedule_id, row, number, x_coordinate, y_coordinate, status, price_adjustment, secure_id, created_by, created_date, modified_by, modified_date, version)
SELECT 
    1 as movie_schedule_id,
    s.row,
    s.number,
    ss.x_coordinate,
    ss.y_coordinate,
    'AVAILABLE' as status,
    0.0 as price_adjustment,
    gen_random_uuid() as secure_id,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM studio_seat ss
JOIN seat s ON ss.seat_id = s.id
WHERE ss.studio_id = 1;

-- For Studio 2's movie schedule
INSERT INTO movie_schedule_seat (movie_schedule_id, row, number, x_coordinate, y_coordinate, status, price_adjustment, secure_id, created_by, created_date, modified_by, modified_date, version)
SELECT 
    2 as movie_schedule_id,
    s.row,
    s.number,
    ss.x_coordinate,
    ss.y_coordinate,
    'AVAILABLE' as status,
    0.0 as price_adjustment,
    gen_random_uuid() as secure_id,
    'SYSTEM' as created_by,
    CURRENT_TIMESTAMP as created_date,
    'SYSTEM' as modified_by,
    CURRENT_TIMESTAMP as modified_date,
    0 as version
FROM studio_seat ss
JOIN seat s ON ss.seat_id = s.id
WHERE ss.studio_id = 2;

-- User
INSERT INTO "users" (secure_id, username, password, address, created_by, created_date, modified_by, modified_date, version)
VALUES 
('550e8400-e29b-41d4-a716-446655440000', 'gen', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaVNaUQbr1gioaWPn4t1KsnmG', 'Jakarta, Indonesia', 'SYSTEM', CURRENT_TIMESTAMP, 'SYSTEM', CURRENT_TIMESTAMP, 0); 