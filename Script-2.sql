
--  3.2 Script SQL DML para carregamento de dados de demonstração
--
--  Organização:
--    Bloco 0 - Dados comuns a todas as clínicas (grupo)
--    Bloco 1 - Clínica de Lisboa  (Jorge Gonçalves, A52345)
--    Bloco 2 - Clínica de Guimaraes (Helena Nina, A52708)
--    Bloco 3 - Clínica de Sintra  (Margarida Andrade, A52146)
--
--  Os blocos têm de ser corridos por esta ordem.
--  Para não haver conflitos, cada elemento usa uma gama própria de números:
--    numAto: Lisboa 101-199 | Guimaraes 201-299 | Sintra 301-399
-- =====================================================================

USE clinica;



-- BLOCO 0 - DADOS COMUNS (tabelas de referência, partilhadas por todos)

INSERT INTO Categoria (designacao) VALUES
    ('Médico'),                                           -- 1
    ('Enfermeiro'),                                       -- 2
    ('Técnico Superior de Diagnóstico e Terapêutica'),    -- 3
    ('Fisioterapeuta'),                                   -- 4
    ('Psicólogo'),                                        -- 5
    ('Auxiliar de Ação Médica');                          -- 6

INSERT INTO Especialidade (designacao) VALUES
    ('Medicina Geral e Familiar'),   -- 1
    ('Cardiologia'),                 -- 2
    ('Pediatria'),                   -- 3
    ('Dermatologia'),                -- 4
    ('Ortopedia');                   -- 5

INSERT INTO TipoCuidado (designacao) VALUES
    ('Consultas Médicas de Especialidade'),               -- 1
    ('Exames Complementares de Diagnóstico'),             -- 2
    ('Intervenções Cirúrgicas e Bloco Ambulatório'),      -- 3
    ('Medicina Preventiva e Promoção da Saúde'),          -- 4
    ('Tratamentos Terapêuticos e Atos de Enfermagem'),    -- 5
    ('Reabilitação e Fisioterapia'),                      -- 6
    ('Saúde Mental e Acompanhamento Psicológico');        -- 7

INSERT INTO Envolver (codTipoCuidado, codCategoria) VALUES
    (1, 1),           -- Consultas: Médico
    (2, 3),           -- Exames: TSDT
    (3, 1), (3, 2),   -- Intervenções cirúrgicas: Médico e Enfermeiro
    (4, 1), (4, 2),   -- Medicina preventiva: Médico e Enfermeiro
    (5, 2),           -- Tratamentos e atos de enfermagem: Enfermeiro
    (6, 4),           -- Reabilitação: Fisioterapeuta
    (7, 5);           -- Saúde mental: Psicólogo

INSERT INTO Patologia (codICD11, designacao) VALUES
    ('5A11', 'Diabetes mellitus tipo 2'),
    ('BA00', 'Hipertensão essencial'),
    ('CA23', 'Asma'),
    ('BA41', 'Enfarte agudo do miocárdio');

INSERT INTO Procedimento (designacao, tipo) VALUES
    ('Excisão de quisto sebáceo', 'cirurgia'),            -- 1
    ('Sessão de fisioterapia', 'tratamento'),             -- 2
    ('Administração de injetável', 'ato de enfermagem'),  -- 3
    ('Penso simples', 'ato de enfermagem');               -- 4

INSERT INTO Vacina (nome) VALUES
    ('Gripe'),                    -- 1
    ('Tétano e difteria (Td)'),   -- 2
    ('COVID-19');                 -- 3

INSERT INTO Alergenio (designacao, tipo) VALUES
    ('Penicilina', 'medicamentoso'),          -- 1
    ('Amendoim', 'alimentar'),                -- 2
    ('Pólen de gramíneas', 'ambiental');      -- 3


-- BLOCO 1 - CLÍNICA Jorge Gonçalves (A52345)

-- BLOCO 2 - CLÍNICA DE  Helena Nina (A52708)

INSERT INTO Clinica (localidade, morada, latitude, longitude) VALUES
    ('Guimaraes', 'Alameda Dr. Alfredo Pimenta', 41.4481, -8.29954);

INSERT INTO Horario (localidade, diaSemana, horaAbertura, horaFecho) VALUES
    ('Guimaraes', 'segunda', '08:30', '19:00'),
    ('Guimaraes', 'terça',   '08:30', '19:00'),
    ('Guimaraes', 'quarta',  '08:30', '19:00'),
    ('Guimaraes', 'quinta',  '08:30', '19:00'),
    ('Guimaraes', 'sexta',   '08:30', '19:00');

INSERT INTO Disponibilizar (localidade, diaSemana, codTipoCuidado) VALUES
    ('Guimaraes', 'segunda', 1), ('Guimaraes', 'segunda', 6),
    ('Guimaraes', 'terça',   1), ('Guimaraes', 'terça',   6),
    ('Guimaraes', 'quarta',  1), ('Guimaraes', 'quarta',  6),
    ('Guimaraes', 'quinta',  1), ('Guimaraes', 'quinta',  6),
    ('Guimaraes', 'sexta',   1), ('Guimaraes', 'sexta',   6);

INSERT INTO Pessoa (NIF, nomeCompleto, dataNascimento, genero, morada, pais, distrito, concelho, freguesia) VALUES
    ('213333333', 'Carla Mendes', '1975-11-20', 'F', 'Rua Almirante Reis, 8',            'Portugal', 'Guimaraes', 'Guimaraes', 'São Sebastião'),
    ('214444444', 'Duarte Pires', '1988-01-30', 'M', 'Av. Luísa Todi, 150',              'Portugal', 'Guimaraes', 'Guimaraes', 'São Julião'),
    ('222222222', 'Helena Costa', '1995-12-01', 'F', 'Rua Dr. António Manuel Gamito, 5', 'Portugal', 'Guimaraes', 'Guimaraes', 'São Sebastião');

INSERT INTO Telefone (NIF, telefone) VALUES
    ('213333333', '934567890');

INSERT INTO Profissional (NIF, numProfissional, numDocIdentificacao, nomeClinico, fotografia, estado, codCategoria, codEspecialidade) VALUES
    ('213333333', 10002, '34567890', 'Dra. Carla Mendes', 'fotos/carla_mendes.jpg', 'Ativo', 1, 2),
    ('214444444', 30001, '45678901', 'Ft. Duarte Pires',  'fotos/duarte_pires.jpg', 'Ativo', 4, NULL);

INSERT INTO Atuar (NIF, codEspecialidade) VALUES
    ('213333333', 1);   -- Carla: Medicina Geral e Familiar

INSERT INTO Vincular (NIF, localidade, tipoVinculo) VALUES
    ('213333333', 'Guimaraes', 'contrato de trabalho'),
    ('214444444', 'Guimaraes', 'avença');

INSERT INTO Turno (NIF, localidade, diaSemana, horaInicio, horaFim) VALUES
    ('213333333', 'Guimaraes', 'terça',   '09:00', '17:00'),
    ('214444444', 'Guimaraes', 'segunda', '09:00', '13:00');

INSERT INTO Utente (NIF, numSNS, grupoSanguineo, nomeContactoEmerg, parentContactoEmerg, telContactoEmerg, estiloVida) VALUES
    ('222222222', '100000002', 'O-', 'Rui Costa', 'pai', '965444555', 'Pratica corrida 3 vezes por semana');

INSERT INTO Herdar (NIF, codICD11, grauParent) VALUES
    ('222222222', '5A11', 'mãe');

INSERT INTO Reagir (NIF, codAlergenio, reacao) VALUES
    ('222222222', 3, 'Rinite na primavera');

INSERT INTO AtoMedico (numAto, dataHoraAgenda, dataHoraAtend, estado, motivo, anamnese, pressaoArterial, freqCardiaca,
                       temperatura, peso, altura, notasClinicas, planoTerapeutico, avaliacao, comentario,
                       NIFUtente, localidade, codTipoCuidado, NIFPreferido, NIFResponsavel) VALUES
    -- sessão de fisioterapia da Helena com o Duarte (segunda-feira)
    (201, '2026-10-05 10:00', '2026-10-05 10:00', 'realizado', 'Dor lombar após esforço',
     'Dor lombar há duas semanas', '118/76', 66, 36.4, 61.00, 1.68,
     'Contratura muscular lombar', '6 sessões de fisioterapia', 'gostei', NULL,
     '222222222', 'Guimaraes', 6, NULL, '214444444'),
    -- consulta cancelada da Helena com a Dra. Carla (terça-feira)
    (202, '2026-11-17 10:00', NULL, 'cancelado', 'Dores de cabeça frequentes', NULL, NULL, NULL,
     NULL, NULL, NULL, NULL, NULL, NULL, NULL,
     '222222222', 'Guimaraes', 1, '213333333', NULL);

INSERT INTO Executar (numAto, codProcedimento) VALUES
    (201, 2);   -- sessão de fisioterapia



-- BLOCO 3 - CLÍNICA DE  Margarida Andrade (A52146)





-- #####################################################################
-- VERIFICAÇÃO
SELECT * FROM Clinica;
SELECT * FROM AtoMedico;