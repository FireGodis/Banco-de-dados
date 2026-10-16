CREATE TABLE project (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    repository_url TEXT UNIQUE
);

CREATE TABLE technology (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE project_technology (
    project_id BIGINT NOT NULL REFERENCES project(id) ON DELETE CASCADE,
    technology_id BIGINT NOT NULL REFERENCES technology(id),
    PRIMARY KEY (project_id, technology_id)
);

INSERT INTO project (name, repository_url) VALUES
    ('API de tarefas', 'https://github.com/FireGodis/Backend-e-APIs');
INSERT INTO technology (name) VALUES ('PostgreSQL'), ('REST');
INSERT INTO project_technology (project_id, technology_id)
SELECT p.id, t.id FROM project p CROSS JOIN technology t
WHERE p.name = 'API de tarefas' AND t.name IN ('PostgreSQL', 'REST');

SELECT p.name, array_agg(t.name ORDER BY t.name) AS technologies
FROM project p
JOIN project_technology pt ON pt.project_id = p.id
JOIN technology t ON t.id = pt.technology_id
GROUP BY p.id, p.name;
