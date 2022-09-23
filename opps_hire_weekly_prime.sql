/* AA : AA Main dashboard : weekly prime hires by approved date : prod */ 
SELECT
   str_to_date(concat(yearweek(`Opportunities`.`reviewed`),'Sunday'),'%X%V %W') AS `date`,
   count(distinct `opportunity_operational_hires`.`opportunity_id`) AS `opps_hire_weekly_prime`
FROM
   `opportunity_operational_hires`
   LEFT JOIN `opportunities` `Opportunities` ON `opportunity_operational_hires`.`opportunity_id` = `Opportunities`.`id`
WHERE
   (
      `opportunity_operational_hires`.`hiring_date` > "2021-7-18"
      AND `opportunity_operational_hires`.`hiring_date` < date(now(6))
      AND (`Opportunities`.`fulfillment` like '%prime%' OR `Opportunities`.`fulfillment` like '%agile%' or `Opportunities`.`fulfillment` like '%staff_augmentation%')
   )
GROUP BY
   str_to_date(concat(yearweek(`Opportunities`.`reviewed`),'Sunday'),'%X%V %W')
ORDER BY
   str_to_date(concat(yearweek(`Opportunities`.`reviewed`),'Sunday'),'%X%V %W') ASC