
-- ✅ DML COMPLETO – Banco de Dados Hotelaria

-- 🔹 INSERTS
USE hotelaria_db;
-- Filial
INSERT INTO Filial (cnpj, nome, endereco, responsavel, tipo, status_operacao)
VALUES ('11.222.333/0001-44', 'Hotel Estrela do Mar', 'Rua do Sol, 100', 'Carlos Dias', 'Hotel', 'Operando');

-- Horário de Funcionamento
INSERT INTO Horario_Funcionamento (id_filial, dia_semana, hora_abertura, hora_fechamento, observacoes)
VALUES (1, 'Segunda-feira', '07:00:00', '22:00:00', 'Fechado em feriados');

-- Acomodação
INSERT INTO Acomodacao (id_filial, andar, tipo, capacidade, valor_alta_temp, valor_baixa_temp, comodidades, acessibilidade)
VALUES (1, 3, 'Suíte Deluxe', 3, 450.00, 350.00, 'WiFi, TV, Ar-condicionado, Banheira', 'Sim');

-- Hóspede
INSERT INTO Hospede (cpf, nome, rg, nascimento, estado_civil, nacionalidade, endereco, profissao, obs_medica, preferencias)
VALUES ('12345678901', 'Juliana Costa', 'MG1234567', '1992-06-15', 'Solteiro', 'Brasileira', 'Rua Azul, 55', 'Designer', '', 'andar alto');

-- Funcionário
INSERT INTO Funcionario (nome_funcionario, funcao, escala, id_filial, permissoes, salario_base)
VALUES ('Marcos Lima', 'Gerente', 'Integral', 1, 'Administração total', 4800.00);

-- Origem da Reserva
INSERT INTO Origem_Reserva (descricao_origem)
VALUES ('Site oficial');

-- Reserva
INSERT INTO Reserva (id_filial, id_acomodacao, checkin_previsto, checkout_previsto, numero_hospedes, valor_estimado, pagamento_previsto, status, id_origem)
VALUES (1, 1, '2025-07-10', '2025-07-15', 2, 1750.00, 1750.00, 'Confirmada', 1);

-- Reserva_has_Hospede
INSERT INTO Reserva_has_Hospede (id_reserva, id_hospede)
VALUES (1, 1);

-- Item de Consumo
INSERT INTO Item_Consumo (id_reserva, nome_item, categoria, quantidade, valor_unitario, valor_total, data_consumo)
VALUES (1, 'Água Mineral', 'Bebidas', 3, 4.00, 12.00, '2025-07-11');

-- Fatura
INSERT INTO Fatura (id_reserva, data_emissao, data_vencimento, valor_total, valor_pago, status_pagamento, forma_pagamento)
VALUES (1, '2025-07-05', '2025-07-15', 1762.00, 0.00, 'Pendente', 'Cartão de Crédito');

-- Check-in/Checkout
INSERT INTO Historico_Checkin_Checkout (id_reserva, data_checkin, data_checkout, hora_checkin, hora_checkout, status_checkin, status_checkout)
VALUES (1, '2025-07-10', NULL, '14:00:00', NULL, 'Realizado', 'Pendente');

-- Manutenção
INSERT INTO Manutencao (id_acomodacao, tipo_manutencao, descricao, status, data_agendada, equipe_responsavel)
VALUES (1, 'Limpeza de ar', 'Troca de filtros e revisão do ar-condicionado', 'Agendada', '2025-07-09', 'Equipe Técnica 1');

-- Histórico de Manutenção
INSERT INTO Historico_Manutencao (id_acomodacao, descricao_manutencao, data_inicio, data_fim, custo_manutencao, tipo_manutencao)
VALUES (1, 'Reparo no encanamento do banheiro', '2025-06-01', '2025-06-03', 320.00, 'Corretiva');

-- Avaliação
INSERT INTO Avaliacoes_de_Hospedes (id_hospede, id_filial, id_reserva, nota, comentario, data_avaliacao)
VALUES (1, 1, 1, 4, 'Ótimo hotel, apenas o ar estava fraco.', '2025-07-16');

-- Telefones e Emails
INSERT INTO Telefone_Filial (id_filial, numero, tipo) VALUES (1, '(11)98765-4321', 'WhatsApp');
INSERT INTO Email_Filial (id_filial, email, tipo) VALUES (1, 'contato@estreladomar.com', 'Comercial');

INSERT INTO Telefone_Hospede (id_hospede, numero, tipo) VALUES (1, '(31)91234-5678', 'Pessoal');
INSERT INTO Email_Hospede (id_hospede, email, tipo) VALUES (1, 'juliana@email.com', 'Principal');

INSERT INTO Telefone_Funcionario (id_funcionario, numero, tipo) VALUES (1, '(11)98888-7766', 'Corporativo');
INSERT INTO Email_Funcionario (id_funcionario, email, tipo) VALUES (1, 'marcos.lima@hotel.com', 'Trabalho');

-- Veículo do Hóspede
INSERT INTO Veiculo_Hospede (id_hospede, placa, modelo, marca, cor, observacoes)
VALUES (1, 'ABC1D23', 'HB20', 'Hyundai', 'Branco', 'Estacionado na vaga 12');

-- Serviço Extra
INSERT INTO Servico_Extra (id_filial, nome_servico, descricao, valor_unitario)
VALUES (1, 'Massagem Relaxante', 'Sessão de 30 minutos', 100.00);

-- Promoção
INSERT INTO Promocao (data_inicio, data_fim, descricao, tipo_quarto, combo, feriado, desconto_aplicado)
VALUES ('2025-06-01', '2025-06-30', '10% OFF para suítes em junho', 'Suíte Deluxe', 'Suíte + Café', FALSE, 10.00);

-- Marketing
INSERT INTO Marketing (descricao, canal, redes_sociais, email, quantidade_reservas)
VALUES ('Campanha de Inverno', 'Redes Sociais', '@hotel_estrela', 'marketing@hotel.com', 85);

-- Log de sistema
INSERT INTO Log_Sistema (id_funcionario, acao_realizada, data_hora, ip_maquina)
VALUES (1, 'Inserção de nova reserva', NOW(), '192.168.0.10');

-- 🔹 UPDATES

UPDATE Fatura SET valor_pago = 1762.00, status_pagamento = 'Pago' WHERE id_reserva = 1;
UPDATE Avaliacoes_de_Hospedes SET nota = 5 WHERE id_avaliacao = 1;

-- 🔹 DELETES

DELETE FROM Item_Consumo WHERE nome_item = 'Água Mineral';

-- 🔹 SELECTS COM FILTRO

SELECT tipo, capacidade FROM Acomodacao WHERE capacidade > 2;
SELECT * FROM Reserva WHERE valor_estimado > 1500;
SELECT nome_funcionario, salario_base FROM Funcionario WHERE salario_base > 3000;
SELECT descricao FROM Promocao WHERE MONTH(data_inicio) = 6;
SELECT h.nome, v.modelo, v.placa FROM Hospede h
JOIN Veiculo_Hospede v ON h.id_hospede = v.id_hospede;
