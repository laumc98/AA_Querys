/* AA : AA Main dashboard : awareness : prod */ 
SELECT
    `metrics_users`.`id` AS `SubjectID`,
    `metrics_users`.`awareness_answer` AS `awareness_answer`
FROM
    `metrics_users`
    LEFT JOIN `users_user` `Users User` ON `metrics_users`.`id` = `Users User`.`id`