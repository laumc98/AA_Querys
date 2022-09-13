/* AA : Users segmentation: rol, country, genome completion : prod */ 
SELECT
    people.gg_id AS `gg_id`,
    people.id AS `Person ID`,
    people.current_role AS `role`,
    person_location.country AS `Country`,
    person_stats.completion_global AS `genome_completion`
FROM
    people
    LEFT JOIN person_location ON people.id = person_location.person_id
    LEFT JOIN person_stats ON people.id = person_stats.person_id
WHERE 
    DATE(people.created) >= date(date_add(now(6), INTERVAL -366 day))
ORDER BY people.id DESC