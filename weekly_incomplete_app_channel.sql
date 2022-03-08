SELECT str_to_date(concat(yearweek(`source`.`created`), ' Sunday'), '%X%V %W') AS `created`, `source`.`Tracking Codes__utm_medium` AS `Tracking Codes__utm_medium`, count(distinct `source`.`id`) AS `count`
FROM (SELECT `opportunity_candidates`.`application_step` AS `application_step`, `opportunity_candidates`.`created` AS `created`, `opportunity_candidates`.`id` AS `id`, `opportunity_candidates`.`interested` AS `interested`, `opportunity_candidates`.`opportunity_id` AS `opportunity_id`, `opportunity_candidates`.`person_id` AS `person_id`, `opportunity_candidates`.`retracted` AS `retracted`, `opportunity_candidates`.`rank` AS `rank`, `opportunity_candidates`.`reviewed` AS `reviewed`, `opportunity_candidates`.`reviewed_from` AS `reviewed_from`, `Tracking Code Candidates`.`id` AS `Tracking Code Candidates__id`, `Tracking Codes`.`utm_campaign` AS `Tracking Codes__utm_campaign`, `Tracking Codes`.`utm_medium` AS `Tracking Codes__utm_medium`, `Tracking Codes`.`utm_source` AS `Tracking Codes__utm_source`, `Opportunity Members - Opportunity`.`member` AS `Opportunity Members - Opportunity__member`, `Opportunity Members - Opportunity`.`person_id` AS `Opportunity Members - Opportunity__person_id`, `Person Flags - Person`.`opportunity_crawler` AS `Person Flags - Person__opportunity_crawler`, `People`.`username` AS `People__username`, `Opportunities`.`id` AS `Opportunities__id`, `Opportunities`.`created` AS `Opportunities__created`, `Opportunities`.`deadline` AS `Opportunities__deadline`, `Opportunities`.`external_id` AS `Opportunities__external_id`, `Opportunities`.`start_date` AS `Opportunities__start_date`, `Opportunities`.`active` AS `Opportunities__active`, `Opportunities`.`tagline` AS `Opportunities__tagline`, `Opportunities`.`agreement_currency_taxes` AS `Opportunities__agreement_currency_taxes`, `Opportunities`.`agreement_type` AS `Opportunities__agreement_type`, `Opportunities`.`video_url` AS `Opportunities__video_url`, `Opportunities`.`board_version` AS `Opportunities__board_version`, `Opportunities`.`last_updated` AS `Opportunities__last_updated`, `Opportunities`.`last_synced` AS `Opportunities__last_synced`, `Opportunities`.`commitment_hours` AS `Opportunities__commitment_hours`, `Opportunities`.`commitment_id` AS `Opportunities__commitment_id`, `Opportunities`.`published` AS `Opportunities__published`, `Opportunities`.`completion` AS `Opportunities__completion`, `Opportunities`.`published_date` AS `Opportunities__published_date`, `Opportunities`.`reviewed` AS `Opportunities__reviewed`, `Opportunities`.`deleted` AS `Opportunities__deleted`, `Opportunities`.`draft_id` AS `Opportunities__draft_id`, `Opportunities`.`external_application_url` AS `Opportunities__external_application_url`, `Opportunities`.`external_info_source_url` AS `Opportunities__external_info_source_url`, `Opportunities`.`intent` AS `Opportunities__intent`, `Opportunities`.`locale` AS `Opportunities__locale`, `Opportunities`.`modified` AS `Opportunities__modified`, `Opportunities`.`objective` AS `Opportunities__objective`, `Opportunities`.`open_graph` AS `Opportunities__open_graph`, `Opportunities`.`opportunity` AS `Opportunities__opportunity`, `Opportunities`.`prefilled_status` AS `Opportunities__prefilled_status`, `Opportunities`.`remote` AS `Opportunities__remote`, `Opportunities`.`review` AS `Opportunities__review`, `Opportunities`.`sponsor_visa` AS `Opportunities__sponsor_visa`, `Opportunities`.`stable_on` AS `Opportunities__stable_on`, `Opportunities`.`start_option` AS `Opportunities__start_option`, `Opportunities`.`status` AS `Opportunities__status`, `Opportunities`.`detected_language` AS `Opportunities__detected_language`, `Opportunities`.`detected_language_hash` AS `Opportunities__detected_language_hash`, `Opportunities`.`template` AS `Opportunities__template`, `Opportunities`.`timezones` AS `Opportunities__timezones`, `Opportunities`.`applicant_coordinator_person_id` AS `Opportunities__applicant_coordinator_person_id`, `Opportunities`.`fulfillment` AS `Opportunities__fulfillment` FROM `opportunity_candidates`
LEFT JOIN `tracking_code_candidates` `Tracking Code Candidates` ON `opportunity_candidates`.`id` = `Tracking Code Candidates`.`candidate_id` LEFT JOIN `tracking_codes` `Tracking Codes` ON `Tracking Code Candidates`.`tracking_code_id` = `Tracking Codes`.`id` LEFT JOIN `opportunity_members` `Opportunity Members - Opportunity` ON `opportunity_candidates`.`opportunity_id` = `Opportunity Members - Opportunity`.`opportunity_id` LEFT JOIN `person_flags` `Person Flags - Person` ON `Opportunity Members - Opportunity`.`person_id` = `Person Flags - Person`.`person_id` LEFT JOIN `people` `People` ON `opportunity_candidates`.`person_id` = `People`.`id` LEFT JOIN `opportunities` `Opportunities` ON `opportunity_candidates`.`opportunity_id` = `Opportunities`.`id`
WHERE (`Person Flags - Person`.`opportunity_crawler` = FALSE
   AND `Opportunity Members - Opportunity`.`poster` = TRUE AND (NOT (lower(`People`.`username`) like '%test%')
    OR `People`.`username` IS NULL) AND `opportunity_candidates`.`retracted` IS NULL)) `source` WHERE (`source`.`created` >= date(date_add(now(6), INTERVAL -262 day)) AND `source`.`created` < date(date_add(now(6), INTERVAL 1 day)) AND `source`.`interested` IS NULL)
GROUP BY str_to_date(concat(yearweek(`source`.`created`), ' Sunday'), '%X%V %W'), `source`.`Tracking Codes__utm_medium`
ORDER BY str_to_date(concat(yearweek(`source`.`created`), ' Sunday'), '%X%V %W') ASC, `source`.`Tracking Codes__utm_medium` ASC