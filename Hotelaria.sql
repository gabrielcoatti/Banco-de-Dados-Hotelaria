-- 📦 Criação do banco de dados da hotelaria!!!!
CREATE SCHEMA IF NOT EXISTS `hotelaria_db` DEFAULT CHARACTER SET utf8mb4;
USE `hotelaria_db`;

-- 🏢 Tabela: Filial
CREATE TABLE `Filial` (
  `id_filial` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(18) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `responsavel` VARCHAR(255),
  `tipo` ENUM('Hotel', 'Pousada', 'Resort') NOT NULL,
  `status_operacao` VARCHAR(50),
  PRIMARY KEY (`id_filial`)
);

-- 🕒 Tabela: Horário de Funcionamento da Filial
CREATE TABLE `Horario_Funcionamento` (
  `id_horario` INT NOT NULL AUTO_INCREMENT,
  `id_filial` INT NOT NULL,
  `dia_semana` VARCHAR(20),
  `hora_abertura` TIME,
  `hora_fechamento` TIME,
  `observacoes` TEXT,
  PRIMARY KEY (`id_horario`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`)
);

-- 🛏️ Tabela: Acomodação
CREATE TABLE `Acomodacao` (
  `id_acomodacao` INT NOT NULL AUTO_INCREMENT,
  `id_filial` INT NOT NULL,
  `andar` INT,
  `tipo` VARCHAR(100),
  `capacidade` INT,
  `valor_alta_temp` DECIMAL(10, 2),
  `valor_baixa_temp` DECIMAL(10, 2),
  `comodidades` TEXT,
  `acessibilidade` VARCHAR(100),
  PRIMARY KEY (`id_acomodacao`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`)
);

-- 🙋‍♂️ Tabela: Hóspede
CREATE TABLE `Hospede` (
  `id_hospede` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(255),
  `rg` VARCHAR(15),
  `nascimento` DATE,
  `estado_civil` ENUM('Solteiro', 'Casado', 'Divorciado', 'Viúvo'),
  `nacionalidade` VARCHAR(50),
  `endereco` VARCHAR(255),
  `profissao` VARCHAR(100),
  `obs_medica` TEXT,
  `preferencias` TEXT,
  PRIMARY KEY (`id_hospede`)
);

-- 👨‍🔧 Tabela: Funcionário
CREATE TABLE `Funcionario` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome_funcionario` VARCHAR(255),
  `funcao` ENUM('Recepcionista', 'Gerente', 'Camareira', 'Manutenção', 'Outros'),
  `escala` VARCHAR(50),
  `id_filial` INT,
  `permissoes` VARCHAR(255),
  `salario_base` DECIMAL(10,2),
  PRIMARY KEY (`id_funcionario`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`)
);

-- 🌐 Tabela: Origem da Reserva
CREATE TABLE `Origem_Reserva` (
  `id_origem` INT NOT NULL AUTO_INCREMENT,
  `descricao_origem` VARCHAR(100),
  PRIMARY KEY (`id_origem`)
);

-- 📆 Tabela: Reserva
CREATE TABLE `Reserva` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `id_filial` INT NOT NULL,
  `id_acomodacao` INT NOT NULL,
  `checkin_previsto` DATE,
  `checkout_previsto` DATE,
  `numero_hospedes` INT,
  `valor_estimado` DECIMAL(10, 2),
  `pagamento_previsto` DECIMAL(10, 2),
  `status` ENUM('Confirmada', 'Cancelada', 'Concluída', 'Em andamento'),
  `id_origem` INT,
  PRIMARY KEY (`id_reserva`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`),
  FOREIGN KEY (`id_acomodacao`) REFERENCES `Acomodacao` (`id_acomodacao`),
  FOREIGN KEY (`id_origem`) REFERENCES `Origem_Reserva` (`id_origem`)
);

-- 🔗 Tabela associativa: Reserva x Hóspede
CREATE TABLE `Reserva_has_Hospede` (
  `id_reserva` INT NOT NULL,
  `id_hospede` INT NOT NULL,
  PRIMARY KEY (`id_reserva`, `id_hospede`),
  FOREIGN KEY (`id_reserva`) REFERENCES `Reserva` (`id_reserva`),
  FOREIGN KEY (`id_hospede`) REFERENCES `Hospede` (`id_hospede`)
);

-- 🍽️ Tabela: Itens de Consumo
CREATE TABLE `Item_Consumo` (
  `id_item_consumo` INT NOT NULL AUTO_INCREMENT,
  `id_reserva` INT NOT NULL,
  `nome_item` VARCHAR(255),
  `categoria` VARCHAR(50),
  `quantidade` INT,
  `valor_unitario` DECIMAL(10, 2),
  `valor_total` DECIMAL(10, 2),
  `data_consumo` DATE,
  PRIMARY KEY (`id_item_consumo`),
  FOREIGN KEY (`id_reserva`) REFERENCES `Reserva` (`id_reserva`)
);

-- 💸 Tabela: Fatura
CREATE TABLE `Fatura` (
  `id_fatura` INT NOT NULL AUTO_INCREMENT,
  `id_reserva` INT NOT NULL,
  `data_emissao` DATE,
  `data_vencimento` DATE,
  `valor_total` DECIMAL(10, 2),
  `valor_pago` DECIMAL(10, 2),
  `status_pagamento` VARCHAR(50),
  `forma_pagamento` VARCHAR(50),
  PRIMARY KEY (`id_fatura`),
  FOREIGN KEY (`id_reserva`) REFERENCES `Reserva` (`id_reserva`)
);

-- ✅ Tabela: Histórico de Check-in/Check-out
CREATE TABLE `Historico_Checkin_Checkout` (
  `id_checkin_checkout` INT NOT NULL AUTO_INCREMENT,
  `id_reserva` INT NOT NULL,
  `data_checkin` DATE,
  `data_checkout` DATE,
  `hora_checkin` TIME,
  `hora_checkout` TIME,
  `status_checkin` VARCHAR(50),
  `status_checkout` VARCHAR(50),
  PRIMARY KEY (`id_checkin_checkout`),
  FOREIGN KEY (`id_reserva`) REFERENCES `Reserva` (`id_reserva`)
);

-- 🔧 Tabela: Manutenção
CREATE TABLE `Manutencao` (
  `id_manutencao` INT NOT NULL AUTO_INCREMENT,
  `id_acomodacao` INT NOT NULL,
  `tipo_manutencao` VARCHAR(100),
  `descricao` TEXT,
  `status` ENUM('Agendada', 'Em andamento', 'Concluída'),
  `data_agendada` DATE,
  `equipe_responsavel` VARCHAR(255),
  PRIMARY KEY (`id_manutencao`),
  FOREIGN KEY (`id_acomodacao`) REFERENCES `Acomodacao` (`id_acomodacao`)
);

-- 📋 Tabela: Histórico de Manutenção
CREATE TABLE `Historico_Manutencao` (
  `id_historico_manutencao` INT NOT NULL AUTO_INCREMENT,
  `id_acomodacao` INT NOT NULL,
  `descricao_manutencao` TEXT,
  `data_inicio` DATE,
  `data_fim` DATE,
  `custo_manutencao` DECIMAL(10, 2),
  `tipo_manutencao` ENUM('Preventiva', 'Corretiva'),
  PRIMARY KEY (`id_historico_manutencao`),
  FOREIGN KEY (`id_acomodacao`) REFERENCES `Acomodacao` (`id_acomodacao`)
);

-- 🌟 Tabela: Avaliações de Hóspedes
CREATE TABLE `Avaliacoes_de_Hospedes` (
  `id_avaliacao` INT NOT NULL AUTO_INCREMENT,
  `id_hospede` INT NOT NULL,
  `id_filial` INT NOT NULL,
  `id_reserva` INT NOT NULL,
  `nota` INT,
  `comentario` TEXT,
  `data_avaliacao` DATE,
  PRIMARY KEY (`id_avaliacao`),
  FOREIGN KEY (`id_hospede`) REFERENCES `Hospede` (`id_hospede`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`),
  FOREIGN KEY (`id_reserva`) REFERENCES `Reserva` (`id_reserva`)
);

-- ☎️ Tabelas de Contato (Telefones e Emails)
CREATE TABLE `Telefone_Filial` (
  `id_telefone_filial` INT NOT NULL AUTO_INCREMENT,
  `id_filial` INT,
  `numero` VARCHAR(15),
  `tipo` VARCHAR(50),
  PRIMARY KEY (`id_telefone_filial`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`)
);

CREATE TABLE `Email_Filial` (
  `id_email_filial` INT NOT NULL AUTO_INCREMENT,
  `id_filial` INT,
  `email` VARCHAR(255),
  `tipo` VARCHAR(50),
  PRIMARY KEY (`id_email_filial`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`)
);

CREATE TABLE `Telefone_Hospede` (
  `id_telefone_hospede` INT NOT NULL AUTO_INCREMENT,
  `id_hospede` INT,
  `numero` VARCHAR(15),
  `tipo` VARCHAR(50),
  PRIMARY KEY (`id_telefone_hospede`),
  FOREIGN KEY (`id_hospede`) REFERENCES `Hospede` (`id_hospede`)
);

CREATE TABLE `Email_Hospede` (
  `id_email_hospede` INT NOT NULL AUTO_INCREMENT,
  `id_hospede` INT,
  `email` VARCHAR(255),
  `tipo` VARCHAR(50),
  PRIMARY KEY (`id_email_hospede`),
  FOREIGN KEY (`id_hospede`) REFERENCES `Hospede` (`id_hospede`)
);

CREATE TABLE `Telefone_Funcionario` (
  `id_telefone_funcionario` INT NOT NULL AUTO_INCREMENT,
  `id_funcionario` INT,
  `numero` VARCHAR(15),
  `tipo` VARCHAR(50),
  PRIMARY KEY (`id_telefone_funcionario`),
  FOREIGN KEY (`id_funcionario`) REFERENCES `Funcionario` (`id_funcionario`)
);

CREATE TABLE `Email_Funcionario` (
  `id_email_funcionario` INT NOT NULL AUTO_INCREMENT,
  `id_funcionario` INT,
  `email` VARCHAR(255),
  `tipo` VARCHAR(50),
  PRIMARY KEY (`id_email_funcionario`),
  FOREIGN KEY (`id_funcionario`) REFERENCES `Funcionario` (`id_funcionario`)
);

-- 🚗 Tabela: Veículo do Hóspede
CREATE TABLE `Veiculo_Hospede` (
  `id_veiculo` INT NOT NULL AUTO_INCREMENT,
  `id_hospede` INT,
  `placa` VARCHAR(10),
  `modelo` VARCHAR(50),
  `marca` VARCHAR(50),
  `cor` VARCHAR(30),
  `observacoes` TEXT,
  PRIMARY KEY (`id_veiculo`),
  FOREIGN KEY (`id_hospede`) REFERENCES `Hospede` (`id_hospede`)
);

-- 🛎️ Tabela: Serviços Extras
CREATE TABLE `Servico_Extra` (
  `id_servico_extra` INT NOT NULL AUTO_INCREMENT,
  `id_filial` INT,
  `nome_servico` VARCHAR(255),
  `descricao` TEXT,
  `valor_unitario` DECIMAL(10, 2),
  PRIMARY KEY (`id_servico_extra`),
  FOREIGN KEY (`id_filial`) REFERENCES `Filial` (`id_filial`)
);

-- 🎉 Tabela: Promoções
CREATE TABLE `Promocao` (
  `id_promocao` INT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE,
  `data_fim` DATE,
  `descricao` TEXT,
  `tipo_quarto` VARCHAR(100),
  `combo` TEXT,
  `feriado` BOOLEAN,
  `desconto_aplicado` DECIMAL(10, 2),
  PRIMARY KEY (`id_promocao`)
);

-- 📢 Tabela: Marketing
CREATE TABLE `Marketing` (
  `id_campanha` INT NOT NULL AUTO_INCREMENT,
  `descricao` TEXT,
  `canal` ENUM('Email', 'Redes Sociais', 'TV', 'Rádio', 'Outros'),
  `redes_sociais` VARCHAR(255),
  `email` VARCHAR(255),
  `quantidade_reservas` INT,
  PRIMARY KEY (`id_campanha`)
);

-- 🧾 Tabela: Log de Sistema
CREATE TABLE `Log_Sistema` (
  `id_log` INT NOT NULL AUTO_INCREMENT,
  `id_funcionario` INT,
  `acao_realizada` TEXT,
  `data_hora` DATETIME,
  `ip_maquina` VARCHAR(50),
  PRIMARY KEY (`id_log`),
  FOREIGN KEY (`id_funcionario`) REFERENCES `Funcionario` (`id_funcionario`)
);
