/* AA : AA Main dashboard : weekly prime hires by event date : prod */ 
SELECT
   str_to_date(concat(yearweek(`opportunity_operational_hires`.`hiring_date`),' Sunday'),'%X%V %W') AS `date`,
   count(distinct `opportunity_operational_hires`.`opportunity_id`) AS `opps_hire_review_date_prime`
FROM
   `opportunity_operational_hires`
   LEFT JOIN `opportunities` `opportunities__via__opportunit` ON `opportunity_operational_hires`.`opportunity_id` = `opportunities__via__opportunit`.`id`
WHERE
   (
      `opportunities__via__opportunit`.`reviewed` > "2021-7-18"
      AND `opportunities__via__opportunit`.`reviewed` < date(now(6))
      AND (`opportunities`.`fulfillment` like '%prime%' OR `opportunities`.`fulfillment` like '%agile%')
   )
GROUP BY
   str_to_date(concat(yearweek(`opportunity_operational_hires`.`hiring_date`),' Sunday'),'%X%V %W')
ORDER BY
   str_to_date(concat(yearweek(`opportunity_operational_hires`.`hiring_date`),' Sunday'),'%X%V %W') ASC