/* AA : AA Main dashboard : weekly mm per channel : prod */ 
SELECT
    str_to_date(concat(yearweek(`Member Evaluations`.`interested`),' Sunday'),'%X%V %W') AS `date`,
    `source`.`opportunity_id` AS `ID`,
    `source`.`Tracking Codes__utm_medium` AS `Tracking Codes__utm_medium`,
    count(distinct `source`.`id`) AS `weekly_mm_channel`
FROM
    (
        SELECT
            `opportunity_candidates`.`id` AS `id`,
            `opportunity_candidates`.`interested` AS `interested`,
            `opportunity_candidates`.`opportunity_id` AS `opportunity_id`,
            `Tracking Codes`.`utm_medium` AS `Tracking Codes__utm_medium`,
            `Opportunities`.`remote` AS `Opportunities__remote`,
            `Opportunities`.`fulfillment` AS `Opportunities__fulfillment`
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
    LEFT JOIN `member_evaluations` `Member Evaluations` ON `source`.`id` = `Member Evaluations`.`candidate_id`
WHERE
    (
        `Member Evaluations`.`interested` IS NOT NULL
        AND `Member Evaluations`.`interested` > "2021-7-18"
        AND `Member Evaluations`.`interested` < date(date_add(now(6), INTERVAL 1 day))
        AND `source`.`interested` >= date(date_add(now(6), INTERVAL -360 day))
        AND `source`.`interested` < date(date_add(now(6), INTERVAL 1 day))
    )
GROUP BY
    `source`.`Tracking Codes__utm_medium`,
    str_to_date(concat(yearweek(`Member Evaluations`.`interested`),' Sunday'),'%X%V %W'),
    `source`.`opportunity_id`
ORDER BY
    `source`.`Tracking Codes__utm_medium` ASC,
    str_to_date(concat(yearweek(`Member Evaluations`.`interested`),' Sunday'),'%X%V %W') ASC