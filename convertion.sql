/* AA : AA Main dashboard : convertion : prod */ 
SELECT
    `Users User - Referred`.`id` AS `SubjectID`,
    `referrers_referrer`.`intent` AS `intent`
FROM
    `referrers_referrer`
    LEFT JOIN `users_user` `Users User - Referred` ON `referrers_referrer`.`referred_id` = `Users User - Referred`.`id`