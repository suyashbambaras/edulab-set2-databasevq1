WITH numbered_students AS (SELECT id, student,ROW_NUMBER() OVER (ORDER BY student_id) AS row_num FROM students),swapped_seats AS (SELECT s1.id,s1.name,COALESCE(s2.student_id, s1.student_id) 
AS swapped_student_id FROM numbered_students s1 LEFT JOIN numbered_students s2 ON (s1.row_num % 2 = 1 AND s1.row_num + 1 = s2.row_num)UNION ALL SELECT 
        s2.id,
        s2.student,
        s1.id
    FROM 
        numbered_students s1
    LEFT JOIN 
        numbered_students s2
    ON 
        (s1.row_num % 2 = 1 AND s1.row_num + 1 = s2.row_num)
)SELECT 
    id, 
    student,
    swapped_student_id AS seat_id
FROM 
    swapped_seats
ORDER BY 
    id;
