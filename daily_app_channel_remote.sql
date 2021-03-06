/* AA : AA Main dashboard : daily app remote : prod */ 
SELECT
    `source`.`interested` AS `date`,
    `source`.`Tracking Codes__utm_medium` AS `Tracking Codes__utm_medium`,
    count(distinct `source`.`id`) AS `daily_app_channel_remote`
FROM
    (
        SELECT
            `opportunity_candidates`.`id` AS `id`,
            `opportunity_candidates`.`interested` AS `interested`,
            `Tracking Codes`.`utm_medium` AS `Tracking Codes__utm_medium`,
            `Opportunities`.`remote` AS `Opportunities__remote`
        FROM
            `opportunity_candidates`
            LEFT JOIN `tracking_code_candidates` `Tracking Code Candidates` ON `opportunity_candidates`.`id` = `Tracking Code Candidates`.`candidate_id`
            LEFT JOIN `tracking_codes` `Tracking Codes` ON `Tracking Code Candidates`.`tracking_code_id` = `Tracking Codes`.`id`
            LEFT JOIN `opportunity_members` `Opportunity Members - Opportunity` ON `opportunity_candidates`.`opportunity_id` = `Opportunity Members - Opportunity`.`opportunity_id`
            LEFT JOIN `person_flags` `Person Flags - Person` ON `Opportunity Members - Opportunity`.`person_id` = `Person Flags - Person`.`person_id`
            LEFT JOIN `people` `People` ON `opportunity_candidates`.`person_id` = `People`.`id`
            LEFT JOIN `opportunities` `Opportunities` ON `opportunity_candidates`.`opportunity_id` = `Opportunities`.`id`
        WHERE
            (
                `Person Flags - Person`.`opportunity_crawler` = FALSE
                AND `Opportunity Members - Opportunity`.`poster` = TRUE
                AND (
                    NOT (lower(`People`.`username`) like '%test%')
                    OR `People`.`username` IS NULL
                )
                AND `opportunity_candidates`.`retracted` IS NULL
            )
    ) `source`
WHERE
    (
        `source`.`Opportunities__remote` = 1
        AND `source`.`interested` > "2022-3-1"
        AND `source`.`interested` < date(date_add(now(6), INTERVAL 1 day))
    )
GROUP BY
    `source`.`interested`,
    `source`.`Tracking Codes__utm_medium`
ORDER BY
    `source`.`interested` ASC,
    `source`.`Tracking Codes__utm_medium` ASC