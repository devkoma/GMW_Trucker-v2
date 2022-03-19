INSERT INTO `jobs` (name, label, whitelisted) VALUES
('trucker', 'LS Logistics', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
('trucker', 0, 'recruit', 'Fahrer', 250, '{}', '{}'),
('trucker', 1, 'boss', 'Inhaber', 500, '{}', '{}')
;

INSERT INTO `addon_account` (name, label, shared) VALUES
    ('society_trucker', 'Trucker', 0)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_trucker', 'Trucker', 1)
;
