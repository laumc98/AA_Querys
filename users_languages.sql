/* AA : Users segmentation: languages: prod */ 
SELECT
    people.gg_id AS `gg_id`,
    languages.person_id AS `Person ID`,
    languages.language AS `Languages`,
    languages.fluency AS `Languages__fluency`
FROM
    languages
    LEFT JOIN people ON languages.person_id = people.id
WHERE
    (
        languages.active = TRUE
        AND DATE(people.created) >= date(date_add(now(6), INTERVAL -250 day))
    )
ORDER BY languages.person_id DESC