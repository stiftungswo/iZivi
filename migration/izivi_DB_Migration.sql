/*
http://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=Type%20Something%20
ANSI Shadow theme
██████╗  █████╗ ███████╗██╗ ██████╗    ██████╗  █████╗ ████████╗ █████╗ 
██╔══██╗██╔══██╗██╔════╝██║██╔════╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
██████╔╝███████║███████╗██║██║         ██║  ██║███████║   ██║   ███████║
██╔══██╗██╔══██║╚════██║██║██║         ██║  ██║██╔══██║   ██║   ██╔══██║
██████╔╝██║  ██║███████║██║╚██████╗    ██████╔╝██║  ██║   ██║   ██║  ██║
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝ ╚═════╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
*/

INSERT INTO izivi.users (created_at,  updated_at,  deleted_at,  remember_token, email,  password, role,  zdp,  first_name,  last_name,  address,  zip, city,  hometown, birthday, phone_mobile, phone_private, phone_business, bank_iban, health_insurance, work_experience, driving_licence, ga_travelcard, half_fare_travelcard, other_fare_network, regional_center,  internal_note) (SELECT
  NULL AS created_at,
  NULL AS updated_at,
  NULL AS deleted_at,
  NULL AS remember_token,
  CASE
    WHEN stiftun8_iZivi.accounts.email = 'zivi@swo-network.org'
      THEN concat('zivi@swo-network.org@', stiftun8_iZivi.accounts.username, '.no')
    WHEN stiftun8_iZivi.accounts.email = 'keine Angabe '
      THEN concat('keine_Angabe_@', stiftun8_iZivi.accounts.username, '.no')
    WHEN stiftun8_iZivi.accounts.email = ''
      THEN concat('_@', stiftun8_iZivi.accounts.username, '.no')
    WHEN stiftun8_iZivi.accounts.email IS NULL
      THEN concat('IS_NULL@', stiftun8_iZivi.accounts.username, '.no')
    ELSE stiftun8_iZivi.accounts.email
  END AS email,
  stiftun8_iZivi.accounts.password AS password,
  CASE
    WHEN stiftun8_iZivi.accounts.accountid=50
     THEN 1
    WHEN stiftun8_iZivi.accounts.accountid=313
     THEN 1
    WHEN stiftun8_iZivi.accounts.accountid=538
     THEN 1
    WHEN stiftun8_iZivi.accounts.accountid=572
     THEN 1
    WHEN stiftun8_iZivi.accounts.accountid=591
     THEN 1
    WHEN stiftun8_iZivi.accounts.accountid=592
     THEN 1
    WHEN stiftun8_iZivi.accounts.accountid=618
     THEN 1
    WHEN stiftun8_iZivi.accounts.accountid=622
     THEN 1
   ELSE 2
  END AS role,
  stiftun8_iZivi.accounts.username AS zdp,
  stiftun8_iZivi.accounts.firstname AS first_name,
  stiftun8_iZivi.accounts.lastname AS last_name,
  CASE
    WHEN stiftun8_iZivi.zivis.street = ''
      THEN ''
    WHEN stiftun8_iZivi.zivis.street IS NULL
      THEN ''
    ELSE stiftun8_iZivi.zivis.street
  END AS address,
  CASE
    WHEN stiftun8_iZivi.zivis.zip IS NULL OR NOT stiftun8_iZivi.zivis.zip REGEXP '[0-9]+'
      THEN 0000
    ELSE stiftun8_iZivi.zivis.zip
  END AS zip,
  CASE
    WHEN stiftun8_iZivi.zivis.city != ''
      THEN trim(stiftun8_iZivi.zivis.city) ELSE ''
  END,
  CASE
    WHEN stiftun8_iZivi.zivis.hometown = ''
      THEN ''
    WHEN stiftun8_iZivi.zivis.hometown IS NULL
      THEN ''
    ELSE stiftun8_iZivi.zivis.hometown
  END AS hometown,
  CASE
    WHEN stiftun8_iZivi.zivis.dateofbirth IS NOT NULL AND stiftun8_iZivi.zivis.dateofbirth != 0
      THEN stiftun8_iZivi.zivis.dateofbirth ELSE NOW()
  END AS birthday,
  CASE
    WHEN stiftun8_iZivi.zivis.phoneM = ''
      THEN 0000000000
    WHEN stiftun8_iZivi.zivis.phoneM IS NULL
      THEN 0000000000
    ELSE stiftun8_iZivi.zivis.phoneM
  END AS phone_mobile,
  CASE
    WHEN stiftun8_iZivi.zivis.phoneP = ''
      THEN 0000000000
    WHEN stiftun8_iZivi.zivis.phoneP IS NULL
      THEN 0000000000
    ELSE stiftun8_iZivi.zivis.phoneP
  END AS phone_private,
  CASE
    WHEN stiftun8_iZivi.zivis.phoneG = ''
      THEN 0000000000
    WHEN stiftun8_iZivi.zivis.phoneG IS NULL
      THEN 0000000000
    ELSE stiftun8_iZivi.zivis.phoneG
  END AS phone_business,
  '' AS bank_iban,
  CASE WHEN stiftun8_iZivi.zivis.health_insurance IS NULL
    THEN ''
    ELSE stiftun8_iZivi.zivis.health_insurance
  END AS health_insurance,
  stiftun8_iZivi.zivis.berufserfahrung AS work_experience,
  CASE WHEN stiftun8_iZivi.zivis.fahrausweis IS NULL
       THEN 0
       ELSE stiftun8_iZivi.zivis.fahrausweis
  END AS driving_licence,
  CASE WHEN stiftun8_iZivi.zivis.ga IS NULL
       THEN 0
       ELSE stiftun8_iZivi.zivis.ga
  END AS ga_travelcard,
  CASE WHEN stiftun8_iZivi.zivis.halbtax IS NULL
       THEN 0
       ELSE stiftun8_iZivi.zivis.halbtax
  END AS half_fare_travelcard,
  stiftun8_iZivi.zivis.anderesAbo AS other_fare_network,
CASE
    WHEN stiftun8_iZivi.zivis.regionalzentrum = 3
      THEN 2
    WHEN stiftun8_iZivi.zivis.regionalzentrum = 6
      THEN 3
    WHEN stiftun8_iZivi.zivis.regionalzentrum = 7
      THEN 4
    WHEN stiftun8_iZivi.zivis.regionalzentrum = 8
      THEN 5
    WHEN stiftun8_iZivi.zivis.regionalzentrum = 4
      THEN 5 #Luzern gibt es nicht mehr als Zentrum! alles nach Araau
   ELSE 1
  END AS regional_center,
  CASE
    WHEN stiftun8_iZivi.zivis.bemerkung = ''
      THEN ''
    WHEN stiftun8_iZivi.zivis.bemerkung IS NULL
      THEN ''
    ELSE stiftun8_iZivi.zivis.bemerkung
  END AS internal_note
FROM stiftun8_iZivi.accounts
  LEFT JOIN stiftun8_iZivi.zivis ON stiftun8_iZivi.zivis.id=stiftun8_iZivi.accounts.username);

INSERT INTO izivi.specifications (id, name, short_name, working_clothes_payment, working_clothes_expense, working_breakfast_expenses, working_lunch_expenses, working_dinner_expenses, sparetime_breakfast_expenses, sparetime_lunch_expenses, sparetime_dinner_expenses, firstday_breakfast_expenses, firstday_lunch_expenses, firstday_dinner_expenses, lastday_breakfast_expenses, lastday_lunch_expenses, lastday_dinner_expenses, working_time_model, working_time_weekly, accommodation, pocket, manual_file, active) (
Select
stiftun8_iZivi.pflichtenheft.id,
stiftun8_iZivi.pflichtenheft.name,
stiftun8_iZivi.pflichtenheft.short_name,
stiftun8_iZivi.pflichtenheft.working_clothes_payment,
stiftun8_iZivi.pflichtenheft.working_clothes_expense*100,
stiftun8_iZivi.pflichtenheft.working_breakfast_expenses,
stiftun8_iZivi.pflichtenheft.working_lunch_expenses,
stiftun8_iZivi.pflichtenheft.working_dinner_expenses,
stiftun8_iZivi.pflichtenheft.sparetime_breakfast_expenses,
stiftun8_iZivi.pflichtenheft.sparetime_lunch_expenses,
stiftun8_iZivi.pflichtenheft.sparetime_dinner_expenses,
stiftun8_iZivi.pflichtenheft.firstday_breakfast_expenses,
stiftun8_iZivi.pflichtenheft.firstday_lunch_expenses,
stiftun8_iZivi.pflichtenheft.firstday_dinner_expenses,
stiftun8_iZivi.pflichtenheft.lastday_breakfast_expenses,
stiftun8_iZivi.pflichtenheft.lastday_lunch_expenses,
stiftun8_iZivi.pflichtenheft.lastday_dinner_expenses,
stiftun8_iZivi.pflichtenheft.working_time_model,
stiftun8_iZivi.pflichtenheft.working_time_weekly,
stiftun8_iZivi.pflichtenheft.accommodation,
stiftun8_iZivi.pflichtenheft.pocket,
stiftun8_iZivi.pflichtenheft.manualfile AS manual_file,
stiftun8_iZivi.pflichtenheft.active
from stiftun8_iZivi.pflichtenheft);


INSERT INTO izivi.specifications (id, name, short_name, working_clothes_payment, working_clothes_expense, working_breakfast_expenses, working_lunch_expenses, working_dinner_expenses, sparetime_breakfast_expenses, sparetime_lunch_expenses, sparetime_dinner_expenses, firstday_breakfast_expenses, firstday_lunch_expenses, firstday_dinner_expenses, lastday_breakfast_expenses, lastday_lunch_expenses, lastday_dinner_expenses, working_time_model, working_time_weekly, accommodation, pocket, manual_file, active) VALUES
  (19532, 'Gruppeneinsätze, Feldarbeiten', 'F', 'Fr. 60 / Monat, max. Fr. 240', 230, 400, 1700, 700, 400, 900, 700, 400, 1700, 700, 400, 1700, 700, 0, 42.00, 1000, 500, 'conditions.pdf', 0),
  (19535, 'Gruppeneinsätze, Feldarbeiten', 'F', 'Fr. 60 / Monat, max. Fr. 240', 230, 400, 1700, 700, 400, 900, 700, 400, 1700, 700, 400, 1700, 700, 0, 42.00, 1000, 500, 'conditions.pdf', 0);


INSERT INTO izivi.missions (id, created_at, updated_at, deleted_at, user, specification, start, end, draft, eligible_holiday, first_time, long_mission, probation_period, mission_type, feedback_mail_sent, feedback_done) (Select
  stiftun8_iZivi.einsaetze.id,
  NULL AS created_at,
  NULL AS updated_at,
  NULL AS deleted_at,
  (Select id from izivi.users where izivi.users.zdp=(CASE
    WHEN LENGTH(stiftun8_iZivi.einsaetze.ziviId) = 4
      THEN concat('0', stiftun8_iZivi.einsaetze.ziviId)
    ELSE stiftun8_iZivi.einsaetze.ziviId
  END)) AS user,
  stiftun8_iZivi.einsaetze.pflichtenheft AS specification,
  stiftun8_iZivi.einsaetze.start AS start,
  stiftun8_iZivi.einsaetze.end AS end,
  CASE
    WHEN stiftun8_iZivi.einsaetze.aufgebot IS NOT NULL AND stiftun8_iZivi.einsaetze.aufgebot != 0
      THEN stiftun8_iZivi.einsaetze.aufgebot ELSE NULL
  END AS draft,
  stiftun8_iZivi.einsaetze.eligibleholiday AS eligible_holiday,
  stiftun8_iZivi.einsaetze.firsttime AS first_time,
  stiftun8_iZivi.einsaetze.long_employment AS long_mission,
  stiftun8_iZivi.einsaetze.probation_period AS probation_period,
  stiftun8_iZivi.einsaetze.employment_type AS mission_type,
  stiftun8_iZivi.einsaetze.end < NOW() AS feedback_mail_sent,
  0
FROM stiftun8_iZivi.einsaetze WHERE stiftun8_iZivi.einsaetze.ziviId != '' AND stiftun8_iZivi.einsaetze.ziviId != 'gast');

INSERT INTO izivi.report_sheets (SELECT
  stiftun8_iZivi.meldeblaetter.id,
  NULL AS created_at,
  NULL AS updated_at,
  NULL AS deleted_at,
  stiftun8_iZivi.meldeblaetter.start,
  stiftun8_iZivi.meldeblaetter.end,
  (Select id from izivi.users where izivi.users.zdp=(CASE
    WHEN LENGTH(stiftun8_iZivi.meldeblaetter.ziviId) = 4
      THEN concat('0', stiftun8_iZivi.meldeblaetter.ziviId)
    ELSE stiftun8_iZivi.meldeblaetter.ziviId
  END)) AS user,
  stiftun8_iZivi.meldeblaetter.work,
  stiftun8_iZivi.meldeblaetter.work_comment,
  stiftun8_iZivi.meldeblaetter.compholiday_holiday AS company_holiday_holiday,
  stiftun8_iZivi.meldeblaetter.compholiday_comment AS company_holiday_comment,
  stiftun8_iZivi.meldeblaetter.compholiday_vacation AS company_holiday_vacation,
  stiftun8_iZivi.meldeblaetter.workfree,
  stiftun8_iZivi.meldeblaetter.workfree_comment,
  stiftun8_iZivi.meldeblaetter.add_workfree AS additional_workfree,
  stiftun8_iZivi.meldeblaetter.add_workfree_comment AS additional_workfree_comment,
  stiftun8_iZivi.meldeblaetter.ill,
  stiftun8_iZivi.meldeblaetter.ill_comment,
  stiftun8_iZivi.meldeblaetter.holiday,
  stiftun8_iZivi.meldeblaetter.holiday_comment,
  stiftun8_iZivi.meldeblaetter.urlaub AS vacation,
  stiftun8_iZivi.meldeblaetter.urlaub_comment AS vacation_comment,
  stiftun8_iZivi.meldeblaetter.fahrspesen AS driving_charges,
  stiftun8_iZivi.meldeblaetter.fahrspesen_comment AS driving_charges_comment,
  stiftun8_iZivi.meldeblaetter.ausserordentlich AS extraordinarily,
  stiftun8_iZivi.meldeblaetter.ausserordentlich_comment AS extraordinarily_comment,
  stiftun8_iZivi.meldeblaetter.kleider AS clothes,
  stiftun8_iZivi.meldeblaetter.kleider_comment AS clothes_comment,
  stiftun8_iZivi.meldeblaetter.einsaetze_id AS mission,
  stiftun8_iZivi.meldeblaetter.konto_nr AS bank_account_number,
  stiftun8_iZivi.meldeblaetter.beleg_nr AS document_number,
  CASE
    WHEN
      stiftun8_iZivi.meldeblaetter.done
    THEN 3
    ELSE 0
  END AS state
  FROM stiftun8_iZivi.meldeblaetter
    INNER JOIN izivi.users ON izivi.users.zdp=stiftun8_iZivi.meldeblaetter.ziviId
    INNER JOIN izivi.missions ON izivi.missions.id=stiftun8_iZivi.meldeblaetter.einsaetze_id);


INSERT INTO izivi.holidays(date_from, date_to, holiday_type, description)
  (SELECT
    start,
    end,
    1,
    'Betriebsferien' FROM stiftun8_iZivi.companyholidays);

INSERT INTO izivi.holidays(date_from, date_to, holiday_type, description)
  (SELECT
    date,
    date,
    2,
    description FROM stiftun8_iZivi.holidays);

	
/*
██╗   ██╗███████╗███████╗██████╗     ███████╗███████╗███████╗██████╗ ██████╗  █████╗  ██████╗██╗  ██╗███████╗
██║   ██║██╔════╝██╔════╝██╔══██╗    ██╔════╝██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝
██║   ██║███████╗█████╗  ██████╔╝    █████╗  █████╗  █████╗  ██║  ██║██████╔╝███████║██║     █████╔╝ ███████╗
██║   ██║╚════██║██╔══╝  ██╔══██╗    ██╔══╝  ██╔══╝  ██╔══╝  ██║  ██║██╔══██╗██╔══██║██║     ██╔═██╗ ╚════██║
╚██████╔╝███████║███████╗██║  ██║    ██║     ███████╗███████╗██████╔╝██████╔╝██║  ██║╚██████╗██║  ██╗███████║
 ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝╚══════╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝
 
=== types ===
define("TYPE_SINGLE_QUESTION", 1);
define("TYPE_GROUP_TITLE", 2);
define("TYPE_GROUP_QUESTION", 3);
define("TYPE_TEXT", 4);
define("TYPE_SINGLE_QUESTION_2", 5);
define("TYPE_SINGLE_QUESTION_6", 6);
*/

INSERT INTO `user_feedback_questions` (`id`, `created_at`, `updated_at`, `deleted_at`, `question`, `new_page`, `type`, `required`, `custom_info`, `opt1`, `opt2`, `opt3`, `pos`, `active`) VALUES
(1, NULL, NULL, NULL, '', 1, 2, 0, 'SWO als Einsatzbetrieb', '', '', '', 1, 1),
(2, NULL, NULL, NULL, 'Wie wurdest du auf die SWO aufmerksam?', 0, 6, 1, '', '', '', '', 2, 1),
(3, NULL, NULL, NULL, 'Hattest du genügend Informationen zum Einsatzbetrieb?', 0, 1, 1, NULL, 'nein', 'ja', '', 3, 1),
(4, NULL, NULL, NULL, 'Wie zufrieden warst du mit der Anmeldung über iZivi?', 0, 1, 1, NULL, 'nicht zufrieden', 'sehr zufrieden', '', 4, 1),
(5, NULL, NULL, NULL, 'Wie zufrieden warst du mit der Spesenabrechnung?', 0, 1, 1, NULL, 'nicht zufrieden', 'sehr zufrieden', '', 5, 1),
(6, NULL, NULL, NULL, 'Wie wichtig waren folgende Gründe bei deiner Wahl des Einsatzbetriebes?', 0, 2, 0, NULL, 'gar nicht wichtig', 'sehr wichtig', '', 6, 1),
(7, NULL, NULL, NULL, 'Aktive Naturschutzarbeit', 0, 3, 1, NULL, '', '', '', 7, 1),
(8, NULL, NULL, NULL, 'Ort des Einsatzbetriebes', 0, 3, 1, NULL, '', '', '', 8, 1),
(9, NULL, NULL, NULL, 'Möglichkeit einer kurzen Einsatzdauer', 0, 3, 1, NULL, '', '', '', 9, 1),
(10, NULL, NULL, NULL, 'Empfehlung', 0, 3, 1, NULL, '', '', '', 10, 1),
(11, NULL, NULL, NULL, 'Früherer Einsatz bei der SWO', 0, 3, 1, NULL, '', '', '', 11, 1),
(12, NULL, NULL, NULL, 'Wie streng war die Arbeit?', 1, 1, 1, 'Arbeit', 'gar nicht streng', 'sehr streng', '', 12, 1),
(13, NULL, NULL, NULL, 'Wie gut wurde (n) ...', 0, 2, 0, NULL, 'sehr schlecht', 'sehr gut', '', 13, 1),
(14, NULL, NULL, NULL, 'die Arbeitstechniken erklärt?', 0, 3, 1, NULL, '', '', '', 14, 1),
(15, NULL, NULL, NULL, 'der Umgang mit Maschinen erklärt?', 0, 3, 1, NULL, '', '', '', 15, 1),
(16, NULL, NULL, NULL, 'Sinn und Zweck der Projekte erklärt?', 0, 3, 1, NULL, '', '', '', 16, 1),
(17, NULL, NULL, NULL, 'Wie beurteilst du den Zustand der...', 0, 2, 0, NULL, 'sehr schlecht', 'sehr gut', '', 17, 1),
(18, NULL, NULL, NULL, 'Arbeitshilfsmittel? (Handwerkzeug, Fahrzeuge etc.)', 0, 3, 1, NULL, '', '', '', 18, 1),
(19, NULL, NULL, NULL, 'zur Verfügung gestellten Arbeitskleider', 0, 3, 1, NULL, '', '', '', 19, 1),
(20, NULL, NULL, NULL, 'Wie war die Stimmung in der Gruppe während der Arbeit?', 0, 1, 1, NULL, 'sehr schlecht', 'sehr gut', '', 20, 1),
(21, NULL, NULL, NULL, 'Wie fandest du die Gruppengrösse', 0, 1, 1, NULL, 'zu klein', 'zu gross', '', 21, 1),
(22, NULL, NULL, NULL, 'Wie sinnvoll hast du die Projekte empfunden?', 0, 1, 1, NULL, 'gar nicht sinnvoll', 'sehr sinnvoll', '', 22, 1),
(23, NULL, NULL, NULL, 'Wie beurteilst du die Sicherheit während der Arbeit?', 0, 1, 1, NULL, 'gar nicht sicher', 'sehr sicher', '', 23, 1),
(24, NULL, NULL, NULL, 'Waren rauchende Zivi\'s für dich ein Problem ...', 0, 2, 0, NULL, 'gar nicht', 'sehr stark', '', 24, 1),
(25, NULL, NULL, NULL, 'während der Arbeit?', 0, 3, 1, NULL, '', '', '', 25, 1),
(26, NULL, NULL, NULL, 'während der Pausen?', 0, 3, 1, NULL, '', '', '', 26, 1),
(27, NULL, NULL, NULL, 'Bist du selbst Raucher?', 0, 5, 0, NULL, 'nein', 'ja', '', 27, 1),
(28, NULL, NULL, NULL, 'Wie stark stimmst du folgenden Aussagen zu?', 1, 2, 0, 'Einsatzleitung', 'stimme gar nicht zu', 'stimme voll zu', '', 28, 1),
(29, NULL, NULL, NULL, 'Die Anwesenheit eines Einsatzleiters war motivierend.', 0, 3, 1, NULL, '', '', '', 29, 1),
(30, NULL, NULL, NULL, 'Eine höhere Präsenz der Einsatzleiter wäre wünschenswert.', 0, 3, 1, NULL, '', '', '', 30, 1),
(31, NULL, NULL, NULL, 'Eine intensivere persönliche Betreuung wäre gut.', 0, 3, 1, NULL, '', '', '', 31, 1),
(32, NULL, NULL, NULL, 'Der Einsatzleiter stand bei Fragen jeweils zur Verfügung.', 0, 3, 1, NULL, '', '', '', 32, 1),
(33, NULL, NULL, NULL, 'Der Einsatzleiter konnte meine Fragen gut beantworten.', 0, 3, 1, NULL, '', '', '', 33, 1),
(34, NULL, NULL, NULL, 'Der Einsatzleiter wirkte in der Regel fachlich kompetent.', 0, 3, 1, NULL, '', '', '', 34, 1),
(35, NULL, NULL, NULL, 'Ich bekam ein faires Feedback auf meine Arbeit.', 0, 3, 1, NULL, '', '', '', 35, 1),
(36, NULL, NULL, NULL, 'Der Einsatzleiter gab realistische Tagesziele vor.', 0, 3, 1, NULL, '', '', '0', 36, 1),
(37, NULL, NULL, NULL, 'Manuel Brändli', 1, 2, 0, 'Bewertung der Einsatzleiter', 'sehr schlecht', 'sehr gut', 'weiss nicht', 37, 1),
(38, NULL, NULL, NULL, 'Fachliche Kompetenz', 0, 3, 0, NULL, '', '', '', 38, 1),
(39, NULL, NULL, NULL, 'Soziale Kompetenz', 0, 3, 0, NULL, '', '', '', 39, 1),
(40, NULL, NULL, NULL, 'Stimmung während der Arbeit', 0, 3, 0, NULL, '', '', '', 40, 1),
(41, NULL, NULL, NULL, 'Konkret kann verbessert werden :', 0, 4, 0, NULL, '', '', '', 41, 1),
(42, NULL, NULL, NULL, 'Andreas Wolf', 0, 2, 0, NULL, 'sehr schlecht', 'sehr gut', 'weiss nicht', 42, 1),
(43, NULL, NULL, NULL, 'Fachliche Kompetenz', 0, 3, 0, NULL, '', '', '', 43, 1),
(44, NULL, NULL, NULL, 'Soziale Kompetenz', 0, 3, 0, NULL, '', '', '', 44, 1),
(45, NULL, NULL, NULL, 'Stimmung während der Arbeit', 0, 3, 0, NULL, '', '', '', 45, 1),
(46, NULL, NULL, NULL, 'Konkret kann verbessert werden :', 0, 4, 0, NULL, '', '', '', 46, 1),
(47, NULL, NULL, NULL, 'Marc Pfeuti', 0, 2, 0, NULL, 'sehr schlecht', 'sehr gut', 'weiss nicht', 47, 1),
(48, NULL, NULL, NULL, 'Fachliche Kompetenz', 0, 3, 0, NULL, '', '', '', 48, 1),
(49, NULL, NULL, NULL, 'Soziale Kompetenz', 0, 3, 0, NULL, '', '', '', 49, 1),
(50, NULL, NULL, NULL, 'Stimmung während der Arbeit', 0, 3, 0, NULL, '', '', '', 50, 1),
(51, NULL, NULL, NULL, 'Konkret kann verbessert werden :', 0, 4, 0, NULL, '', '', '', 51, 1),
(52, NULL, NULL, NULL, 'Lothar Schroeder', 0, 2, 0, NULL, 'sehr schlecht', 'sehr gut', 'weiss nicht', 52, 0),
(53, NULL, NULL, NULL, 'Fachliche Kompetenz', 0, 3, 0, NULL, '', '', '', 53, 0),
(54, NULL, NULL, NULL, 'Soziale Kompetenz', 0, 3, 0, NULL, '', '', '', 54, 0),
(55, NULL, NULL, NULL, 'Stimmung während der Arbeit', 0, 3, 0, NULL, '', '', '', 55, 0),
(56, NULL, NULL, NULL, 'Konkret kann verbessert werden :', 0, 4, 0, NULL, '', '', '', 56, 0),
(57, NULL, NULL, NULL, 'Daniel Jerjen', 0, 2, 0, NULL, 'sehr schlecht', 'sehr gut', 'weiss nicht', 57, 1),
(58, NULL, NULL, NULL, 'Fachliche Kompetenz', 0, 3, 0, NULL, '', '', '', 58, 1),
(59, NULL, NULL, NULL, 'Soziale Kompetenz', 0, 3, 0, NULL, '', '', '', 59, 1),
(60, NULL, NULL, NULL, 'Stimmung während der Arbeit', 0, 3, 0, NULL, '', '', '', 60, 1),
(61, NULL, NULL, NULL, 'Konkret kann verbessert werden :', 0, 4, 0, NULL, '', '', '', 61, 1),
(62, NULL, NULL, NULL, 'Lukas Geser', 0, 2, 0, NULL, 'sehr schlecht', 'sehr gut', 'weiss nicht', 62, 1),
(63, NULL, NULL, NULL, 'Fachliche Kompetenz', 0, 3, 0, NULL, '', '', '', 63, 1),
(64, NULL, NULL, NULL, 'Soziale Kompetenz', 0, 3, 0, NULL, '', '', '', 64, 1),
(65, NULL, NULL, NULL, 'Stimmung während der Arbeit', 0, 3, 0, NULL, '', '', '', 65, 1),
(66, NULL, NULL, NULL, 'Konkret kann verbessert werden :', 0, 4, 0, NULL, '', '', '', 66, 1),
(67, NULL, NULL, NULL, 'Würdest du die SWO als Einsatzbetrieb weiterempfehlen?', 1, 1, 0, 'Weiteres', 'nein', 'ja', '', 67, 1),
(68, NULL, NULL, NULL, 'Würdest du wieder einmal Zivildienst bei der SWO leisten?', 0, 1, 0, NULL, 'nein', 'ja', '', 68, 1),
(69, NULL, NULL, NULL, 'Höhepunkt (e) meines Zivildiensteinsatzes :', 0, 4, 0, NULL, '', '', '', 69, 1),
(70, NULL, NULL, NULL, 'Tiefpunkt (e) meines Zivildiensteinsatzes :', 0, 4, 0, NULL, '', '', '', 70, 1),
(71, NULL, NULL, NULL, 'Verbesserungsvorschläge :', 0, 4, 0, NULL, '', '', '', 71, 1),
(72, NULL, NULL, NULL, 'Weitere Kommentare :', 0, 4, 0, NULL, '', '', '', 72, 1);

/* Insert custom information*/
UPDATE `user_feedback_questions`
SET custom_info = '"choices":[{"value":"1","text":"Kollegen"},{"value":"2","text":"EIS"},{"value":"3","text":"Website SWO"},{"value":"4","text":"Thomas Winter"},{"value":"5","text":"Früherer Einsatz"},{"value":"6","text":"Anderes"}],'
WHERE id = 2;

/*
██╗   ██╗███╗   ███╗██╗      █████╗ ██╗   ██╗████████╗    ███████╗██╗██╗  ██╗
██║   ██║████╗ ████║██║     ██╔══██╗██║   ██║╚══██╔══╝    ██╔════╝██║╚██╗██╔╝
██║   ██║██╔████╔██║██║     ███████║██║   ██║   ██║       █████╗  ██║ ╚███╔╝ 
██║   ██║██║╚██╔╝██║██║     ██╔══██║██║   ██║   ██║       ██╔══╝  ██║ ██╔██╗ 
╚██████╔╝██║ ╚═╝ ██║███████╗██║  ██║╚██████╔╝   ██║       ██║     ██║██╔╝ ██╗
 ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝
*/
	
UPDATE izivi.users SET first_name = (SELECT REPLACE(first_name, 'Ã©', 'é'));
UPDATE izivi.users SET last_name = (SELECT REPLACE(last_name, 'Ã©', 'é'));
UPDATE izivi.users SET address = (SELECT REPLACE(address, 'Ã©', 'é'));
UPDATE izivi.users SET city = (SELECT REPLACE(city, 'Ã©', 'é'));
UPDATE izivi.users SET hometown = (SELECT REPLACE(hometown, 'Ã©', 'é'));
UPDATE izivi.users SET work_experience = (SELECT REPLACE(work_experience, 'Ã©', 'é'));
UPDATE izivi.specifications SET name = (SELECT REPLACE(name, 'Ã©', 'é'));

UPDATE izivi.users SET first_name = (SELECT REPLACE(first_name, 'Ã¤', 'ä'));
UPDATE izivi.users SET last_name = (SELECT REPLACE(last_name, 'Ã¤', 'ä'));
UPDATE izivi.users SET address = (SELECT REPLACE(address, 'Ã¤', 'ä'));
UPDATE izivi.users SET city = (SELECT REPLACE(city, 'Ã¤', 'ä'));
UPDATE izivi.users SET hometown = (SELECT REPLACE(hometown, 'Ã¤', 'ä'));
UPDATE izivi.users SET work_experience = (SELECT REPLACE(work_experience, 'Ã¤', 'ä'));
UPDATE izivi.specifications SET name = (SELECT REPLACE(name, 'Ã¤', 'ä'));

UPDATE izivi.users SET first_name = (SELECT REPLACE(first_name, 'Ã¼', 'ü'));
UPDATE izivi.users SET last_name = (SELECT REPLACE(last_name, 'Ã¼', 'ü'));
UPDATE izivi.users SET address = (SELECT REPLACE(address, 'Ã¼', 'ü'));
UPDATE izivi.users SET city = (SELECT REPLACE(city, 'Ã¼', 'ü'));
UPDATE izivi.users SET hometown = (SELECT REPLACE(hometown, 'Ã¼', 'ü'));
UPDATE izivi.users SET work_experience = (SELECT REPLACE(work_experience, 'Ã¼', 'ü'));
UPDATE izivi.specifications SET name = (SELECT REPLACE(name, 'Ã¼', 'ü'));

UPDATE izivi.users SET first_name = (SELECT REPLACE(first_name, 'ï¿½', 'ü'));
UPDATE izivi.users SET last_name = (SELECT REPLACE(last_name, 'ï¿½', 'ü'));
UPDATE izivi.users SET address = (SELECT REPLACE(address, 'ï¿½', 'ü'));
UPDATE izivi.users SET city = (SELECT REPLACE(city, 'ï¿½', 'ü'));
UPDATE izivi.users SET hometown = (SELECT REPLACE(hometown, 'ï¿½', 'ü'));
UPDATE izivi.users SET work_experience = (SELECT REPLACE(work_experience, 'ï¿½', 'ü'));
UPDATE izivi.specifications SET name = (SELECT REPLACE(name, 'ï¿½', 'ü'));

UPDATE izivi.users SET first_name = (SELECT REPLACE(first_name, 'Ã¶', 'ö'));
UPDATE izivi.users SET last_name = (SELECT REPLACE(last_name, 'Ã¶', 'ö'));
UPDATE izivi.users SET address = (SELECT REPLACE(address, 'Ã¶', 'ö'));
UPDATE izivi.users SET city = (SELECT REPLACE(city, 'Ã¶', 'ö'));
UPDATE izivi.users SET hometown = (SELECT REPLACE(hometown, 'Ã¶', 'ö'));
UPDATE izivi.users SET work_experience = (SELECT REPLACE(work_experience, 'Ã¶', 'ö'));
UPDATE izivi.specifications SET name = (SELECT REPLACE(name, 'Ã¶', 'ö'));

UPDATE izivi.users SET first_name = (SELECT REPLACE(first_name, 'Ã', 'í'));
UPDATE izivi.users SET last_name = (SELECT REPLACE(last_name, 'Ã', 'í'));
UPDATE izivi.users SET address = (SELECT REPLACE(address, 'Ã', 'í'));
UPDATE izivi.users SET city = (SELECT REPLACE(city, 'Ã', 'í'));
UPDATE izivi.users SET hometown = (SELECT REPLACE(hometown, 'Ã', 'í'));
UPDATE izivi.users SET work_experience = (SELECT REPLACE(work_experience, 'Ã', 'í'));
UPDATE izivi.specifications SET name = (SELECT REPLACE(name, 'Ã', 'í'));


/*
██████╗  █████╗ ███╗   ██╗██╗  ██╗     █████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███╗   ██╗████████╗███████╗
██╔══██╗██╔══██╗████╗  ██║██║ ██╔╝    ██╔══██╗██╔════╝██╔════╝██╔═══██╗██║   ██║████╗  ██║╚══██╔══╝██╔════╝
██████╔╝███████║██╔██╗ ██║█████╔╝     ███████║██║     ██║     ██║   ██║██║   ██║██╔██╗ ██║   ██║   ███████╗
██╔══██╗██╔══██║██║╚██╗██║██╔═██╗     ██╔══██║██║     ██║     ██║   ██║██║   ██║██║╚██╗██║   ██║   ╚════██║
██████╔╝██║  ██║██║ ╚████║██║  ██╗    ██║  ██║╚██████╗╚██████╗╚██████╔╝╚██████╔╝██║ ╚████║   ██║   ███████║
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝

==== account types ====
0 Bank Account with old number system
1 Post Finance Account with old number system

3 not to be converted
4 to be converted by the IBAN calculation tool

==== Generating the CSV file ====

SET @row_number = 0;
SELECT (@row_number:=@row_number + 1) AS 'row', id AS 'zdp', bank_clearing, kontoNr FROM no_iban;

Export with Separator ";" and no escaping

==== Using the IBAN tool ====

See
https://www.six-interbank-clearing.com/de/home/standardization/iban/iban-tool.html
*/

DROP TABLE IF EXISTS izivi.no_iban;
CREATE TABLE izivi.no_iban LIKE stiftun8_iZivi.zivis; 
INSERT izivi.no_iban SELECT * FROM stiftun8_iZivi.zivis;

/* Post finance accounts */
UPDATE izivi.no_iban SET kontoNr = REPLACE(kontoNR, "Postcheque", "PC");
UPDATE izivi.no_iban SET kontoNr = REPLACE(kontoNR, "Postkonto", "PC");

/* Mark unresolvable if the correct format is not found */
UPDATE izivi.no_iban 
SET account_type = 3 
WHERE account_type = 0 
AND kontoNr NOT REGEXP('^.*([0-9]{2,5}[\-.][0-9]{2,5})+.*$');

/* Mark as post finance account if 'PC' is in the text */
UPDATE izivi.no_iban SET account_type = 1 WHERE kontoNr LIKE '%PC%';

/* Accounts with a valid IBAN don't need to be converted */
UPDATE izivi.no_iban SET account_type = 3 WHERE kontoNr REGEXP('.*(CH[0-9][0-9]).*');

/* Post finance BC code is 9000 */
UPDATE izivi.no_iban SET bank_clearing = 9000 WHERE account_type = 1;

/* remove all except numbers and '-' from the bank account */
DROP FUNCTION IF EXISTS numbersandhyphen; 
DELIMITER | 
CREATE FUNCTION numbersandhyphen( str TEXT ) RETURNS CHAR(255) 
BEGIN 
  DECLARE i, len SMALLINT DEFAULT 1; 
  DECLARE ret TEXT DEFAULT ''; 
  DECLARE c CHAR(1); 
  SET len = CHAR_LENGTH( str ); 
  REPEAT 
    BEGIN 
      SET c = MID( str, i, 1 ); 
      IF c REGEXP '[.0-9\-]' THEN 
        SET ret=CONCAT(ret,c); 
      END IF; 
      SET i = i + 1; 
    END; 
  UNTIL i > len END REPEAT; 
  RETURN ret; 
END | 
DELIMITER ; 

/* Clean up post finance account numbers */
UPDATE izivi.no_iban SET kontoNr = (LOWER(kontoNr)) WHERE account_type = 1;
UPDATE izivi.no_iban SET kontoNr = (SELECT REPLACE(kontoNr, 'pc-konto', 'pc'))  WHERE account_type = 1;
UPDATE izivi.no_iban SET kontoNr = numbersandhyphen(kontoNr) WHERE account_type = 1;

/* Mark unresolvable if there are more than 9 chars */
UPDATE izivi.no_iban SET account_type = 3 WHERE account_type = 1 AND CHAR_LENGTH(kontoNr) > 12;

/* Mark Post Finance acounts for conversion */
UPDATE izivi.no_iban SET account_type = 4 WHERE account_type = 1;

/* Mark unresolvable if no BC is set or if BS contains letters */
UPDATE izivi.no_iban 
SET account_type = 3 
WHERE account_type = 0 
AND (
bank_clearing REGEXP('^.*[A-Za-z]+.*$') 
OR bank_clearing = '' 
);

/* Mark unresolvable if there is more than one account number found */
UPDATE izivi.no_iban 
SET account_type = 3 
WHERE account_type = 0 
AND kontoNr REGEXP('^.*[0-9]+.*[A-Za-z]+.*[0-9]+.*$');

/* Clean up bank accounts without IBAN */
UPDATE izivi.no_iban 
SET account_type = 4, kontoNr = numbersandhyphen(kontoNr) 
WHERE account_type = 0;

/* Copy entries with IBAN number and unresolvable */
UPDATE izivi.users u 
LEFT JOIN izivi.no_iban z 
ON u.zdp = z.id 
SET u.bank_iban = REPLACE(z.kontoNr, '\n', ', ') 
WHERE z.account_type = 2 
OR z.account_type = 3;

/* Delete entries with IBAN and unresolvables, leave others for IBAN translation tool */
DELETE FROM izivi.no_iban 
WHERE account_type = 2
OR account_type = 3;


/*
███████╗██████╗ ███████╗███████╗██████╗  █████╗ ██╗   ██╗    ██████╗ ██████╗ ███████╗    ███████╗██╗██╗     ██╗
██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔══██╗██╔════╝    ██╔════╝██║██║     ██║
█████╗  ██████╔╝█████╗  █████╗  ██║  ██║███████║ ╚████╔╝     ██████╔╝██████╔╝█████╗█████╗█████╗  ██║██║     ██║
██╔══╝  ██╔══██╗██╔══╝  ██╔══╝  ██║  ██║██╔══██║  ╚██╔╝      ██╔═══╝ ██╔══██╗██╔══╝╚════╝██╔══╝  ██║██║     ██║
██║     ██║  ██║███████╗███████╗██████╔╝██║  ██║   ██║       ██║     ██║  ██║███████╗    ██║     ██║███████╗███████╗
╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝╚══════╝╚══════╝

https://awa.zh.ch/internet/volkswirtschaftsdirektion/awa/de/arbeitsbedingungen/infos/feiertage.html
1 'Betriebsferien'
2 'Feiertage'
Date format yyyy-mm-dd (2005-12-27)

source: https://www.feiertagskalender.ch/index.php?geo=3055&jahr=2021&klasse=3
*/

INSERT INTO izivi.holidays(date_from, date_to, holiday_type, description) VALUES
  ('2018-01-01', '2018-01-01', 2, 'Neujahrstag'),
  ('2018-03-30', '2018-03-30', 2, 'Karfreitag'),
  ('2018-04-02', '2018-04-02', 2, 'Ostermontag'),
  ('2018-05-01', '2018-05-01', 2, 'Tag der Arbeit'),
  ('2018-05-10', '2018-05-10', 2, 'Auffahrt'),
  ('2018-05-21', '2018-05-21', 2, 'Pfingstmontag'),
  ('2018-08-01', '2018-08-01', 2, 'Nationalfeiertag'),
  ('2018-12-25', '2018-12-25', 2, 'Weihnachtstag'),
  ('2018-12-26', '2018-12-26', 2, 'Stephanstag'),
  ('2018-12-27', '2018-12-31' , 1, 'Betriebsferien'),

  ('2019-01-01', '2019-01-01', 2, 'Neujahrstag'),
  ('2019-04-19', '2019-04-19', 2, 'Karfreitag'),
  ('2019-04-22', '2019-04-22', 2, 'Ostermontag'),
  ('2019-05-01', '2019-05-01', 2, 'Tag der Arbeit'),
  ('2019-05-30', '2019-05-30', 2, 'Auffahrt'),
  ('2019-06-10', '2019-06-10', 2, 'Pfingstmontag'),
  ('2019-08-01', '2019-08-01', 2, 'Nationalfeiertag'),
  ('2019-12-25', '2019-12-25', 2, 'Weihnachtstag'),
  ('2019-12-26', '2019-12-26', 2, 'Stephanstag'),
  ('2019-12-27', '2019-12-31' , 1, 'Betriebsferien'),

  ('2020-01-01', '2020-01-01', 2, 'Neujahrstag'),
  ('2020-04-10', '2020-04-10', 2, 'Karfreitag'),
  ('2020-04-13', '2020-04-13', 2, 'Ostermontag'),
  ('2020-05-01', '2020-05-01', 2, 'Tag der Arbeit'),
  ('2020-05-21', '2020-05-21', 2, 'Auffahrt'),
  ('2020-06-01', '2020-06-01', 2, 'Pfingstmontag'),
  ('2020-08-01', '2020-08-01', 2, 'Nationalfeiertag'),
  ('2020-12-25', '2020-12-25', 2, 'Weihnachtstag'),
  ('2020-12-26', '2020-12-26', 2, 'Stephanstag'),
  ('2020-12-27', '2020-12-31' , 1, 'Betriebsferien'),

  ('2021-01-01', '2021-01-01', 2, 'Neujahrstag'),
  ('2021-04-02', '2021-04-02', 2, 'Karfreitag'),
  ('2021-04-05', '2021-04-05', 2, 'Ostermontag'),
  ('2021-05-01', '2021-05-01', 2, 'Tag der Arbeit'),
  ('2021-05-13', '2021-05-13', 2, 'Auffahrt'),
  ('2021-05-24', '2021-05-24', 2, 'Pfingstmontag'),
  ('2021-08-01', '2021-08-01', 2, 'Nationalfeiertag'),
  ('2021-12-25', '2021-12-25', 2, 'Weihnachtstag'),
  ('2021-12-26', '2021-12-26', 2, 'Stephanstag'),
  ('2021-12-27', '2021-12-31' , 1, 'Betriebsferien'),

  ('2022-01-01', '2022-01-01', 2, 'Neujahrstag'),
  ('2022-04-15', '2022-04-15', 2, 'Karfreitag'),
  ('2022-04-18', '2022-04-18', 2, 'Ostermontag'),
  ('2022-05-01', '2022-05-01', 2, 'Tag der Arbeit'),
  ('2022-05-26', '2022-05-26', 2, 'Auffahrt'),
  ('2022-06-06', '2022-06-06', 2, 'Pfingstmontag'),
  ('2022-08-01', '2022-08-01', 2, 'Nationalfeiertag'),
  ('2022-12-25', '2022-12-25', 2, 'Weihnachtstag'),
  ('2022-12-26', '2022-12-26', 2, 'Stephanstag'),
  ('2022-12-27', '2022-12-31' , 1, 'Betriebsferien'),

  ('2023-01-01', '2023-01-01', 2, 'Neujahrstag'),
  ('2023-04-07', '2023-04-07', 2, 'Karfreitag'),
  ('2023-04-10', '2023-04-10', 2, 'Ostermontag'),
  ('2023-05-01', '2023-05-01', 2, 'Tag der Arbeit'),
  ('2023-05-18', '2023-05-18', 2, 'Auffahrt'),
  ('2023-05-29', '2023-05-29', 2, 'Pfingstmontag'),
  ('2023-08-01', '2023-08-01', 2, 'Nationalfeiertag'),
  ('2023-12-25', '2023-12-25', 2, 'Weihnachtstag'),
  ('2023-12-26', '2023-12-26', 2, 'Stephanstag'),
  ('2023-12-27', '2023-12-31' , 1, 'Betriebsferien'),

  ('2024-01-01', '2024-01-01', 2, 'Neujahrstag'),
  ('2024-03-29', '2024-03-29', 2, 'Karfreitag'),
  ('2024-04-01', '2024-04-01', 2, 'Ostermontag'),
  ('2024-05-01', '2024-05-01', 2, 'Tag der Arbeit'),
  ('2024-05-09', '2024-05-09', 2, 'Auffahrt'),
  ('2024-05-20', '2024-05-20', 2, 'Pfingstmontag'),
  ('2024-08-01', '2024-08-01', 2, 'Nationalfeiertag'),
  ('2024-12-25', '2024-12-25', 2, 'Weihnachtstag'),
  ('2024-12-26', '2024-12-26', 2, 'Stephanstag'),
  ('2024-12-27', '2024-12-31' , 1, 'Betriebsferien'),

  ('2025-01-01', '2025-01-01', 2, 'Neujahrstag'),
  ('2025-04-18', '2025-04-18', 2, 'Karfreitag'),
  ('2025-04-21', '2025-04-21', 2, 'Ostermontag'),
  ('2025-05-01', '2025-05-01', 2, 'Tag der Arbeit'),
  ('2025-05-29', '2025-05-29', 2, 'Auffahrt'),
  ('2025-06-09', '2025-06-09', 2, 'Pfingstmontag'),
  ('2025-08-01', '2025-08-01', 2, 'Nationalfeiertag'),
  ('2025-12-25', '2025-12-25', 2, 'Weihnachtstag'),
  ('2025-12-26', '2025-12-26', 2, 'Stephanstag'),
  ('2025-12-27', '2025-12-31' , 1, 'Betriebsferien'),

  ('2026-01-01', '2026-01-01', 2, 'Neujahrstag'),
  ('2026-04-03', '2026-04-03', 2, 'Karfreitag'),
  ('2026-04-06', '2026-04-06', 2, 'Ostermontag'),
  ('2026-05-01', '2026-05-01', 2, 'Tag der Arbeit'),
  ('2026-05-14', '2026-05-14', 2, 'Auffahrt'),
  ('2026-05-25', '2026-05-25', 2, 'Pfingstmontag'),
  ('2026-08-01', '2026-08-01', 2, 'Nationalfeiertag'),
  ('2026-12-25', '2026-12-25', 2, 'Weihnachtstag'),
  ('2026-12-26', '2026-12-26', 2, 'Stephanstag'),
  ('2026-12-27', '2026-12-31' , 1, 'Betriebsferien'),

  ('2027-01-01', '2027-01-01', 2, 'Neujahrstag'),
  ('2027-03-26', '2027-03-26', 2, 'Karfreitag'),
  ('2027-03-29', '2027-03-29', 2, 'Ostermontag'),
  ('2027-05-01', '2027-05-01', 2, 'Tag der Arbeit'),
  ('2027-05-06', '2027-05-06', 2, 'Auffahrt'),
  ('2027-05-17', '2027-05-17', 2, 'Pfingstmontag'),
  ('2027-08-01', '2027-08-01', 2, 'Nationalfeiertag'),
  ('2027-12-25', '2027-12-25', 2, 'Weihnachtstag'),
  ('2027-12-26', '2027-12-26', 2, 'Stephanstag'),
  ('2027-12-27', '2027-12-31' , 1, 'Betriebsferien'),

  ('2028-01-01', '2028-01-01', 2, 'Neujahrstag'),
  ('2028-04-14', '2028-04-14', 2, 'Karfreitag'),
  ('2028-04-17', '2028-04-17', 2, 'Ostermontag'),
  ('2028-05-01', '2028-05-01', 2, 'Tag der Arbeit'),
  ('2028-05-25', '2028-05-25', 2, 'Auffahrt'),
  ('2028-06-05', '2028-06-05', 2, 'Pfingstmontag'),
  ('2028-08-01', '2028-08-01', 2, 'Nationalfeiertag'),
  ('2028-12-25', '2028-12-25', 2, 'Weihnachtstag'),
  ('2028-12-26', '2028-12-26', 2, 'Stephanstag'),
  ('2028-12-27', '2028-12-31' , 1, 'Betriebsferien')