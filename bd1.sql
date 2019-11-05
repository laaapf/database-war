DROP DATABASE WARGAME;

CREATE DATABASE IF NOT EXISTS WARGAME;

USE WARGAME;

CREATE TABLE IF NOT EXISTS Usuário (
    Nome CHAR(10) NOT NULL,
    Idade INT UNSIGNED,
    Sexo CHAR(1),
    Ranking INT UNSIGNED NOT NULL,
    ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PartidasGanhas INT UNSIGNED NOT NULL,
    PartidasJogadas INT UNSIGNED NOT NULL,
    TempoJogado TIME NOT NULL,
    CONSTRAINT PKUsuário PRIMARY KEY (ID)
);


CREATE TABLE IF NOT EXISTS Objetivo (
    Descrição INT NOT NULL,
    Categoria CHAR(20) NOT NULL,
    CONSTRAINT PKObjetivo PRIMARY KEY (Descrição)
);

CREATE TABLE IF NOT EXISTS Jogador (
    Cor CHAR(8) NOT NULL,
    ID INT UNSIGNED NOT NULL,
    QuantidadeDeTropas INT UNSIGNED NOT NULL,
    DescriçãoObjetivo INT NOT NULL,
    CONSTRAINT PKJogador PRIMARY KEY (ID , Cor),
    CONSTRAINT FK1Jogador FOREIGN KEY (ID)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2Jogador FOREIGN KEY (DescriçãoObjetivo)
        REFERENCES Objetivo (Descrição)
);


CREATE TABLE IF NOT EXISTS Grupo (
    Nome VARCHAR(30) NOT NULL,
    Descrição VARCHAR(50),
    QuantidadeDeMembros INT UNSIGNED NOT NULL,
    IDCriador INT UNSIGNED NOT NULL,
    CONSTRAINT PKGrupo PRIMARY KEY (Nome),
    CONSTRAINT FKGrupo FOREIGN KEY (IDCriador)
        REFERENCES Usuário (ID)
);



CREATE TABLE IF NOT EXISTS Partida (
    ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    NúmeroDeJogadores INT NOT NULL,
    TempoPartida TIME,
    DataHora DATETIME NOT NULL,
    Vencedor INT UNSIGNED,
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL,
    IDUsuário3 INT UNSIGNED NOT NULL,
    IDUsuário4 INT UNSIGNED,
    IDUsuário5 INT UNSIGNED,
    IDUsuário6 INT UNSIGNED,
    CONSTRAINT PKPartida PRIMARY KEY (ID),
    CONSTRAINT FK1Partida FOREIGN KEY (IDUsuário1)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2Partida FOREIGN KEY (IDUsuário2)
        REFERENCES Usuário (ID),
    CONSTRAINT FK3Partida FOREIGN KEY (IDUsuário3)
        REFERENCES Usuário (ID),
    CONSTRAINT FK4Partida FOREIGN KEY (IDUsuário4)
        REFERENCES Usuário (ID),
    CONSTRAINT FK5Partida FOREIGN KEY (IDUsuário5)
        REFERENCES Usuário (ID),
    CONSTRAINT FK6Partida FOREIGN KEY (IDUsuário6)
        REFERENCES Usuário (ID),
    CONSTRAINT FK7Partida FOREIGN KEY (Vencedor)
        REFERENCES Usuário (ID)
);



CREATE TABLE IF NOT EXISTS Carta (
    Nome INT NOT NULL,
    Tipo CHAR(9) NOT NULL,
    CONSTRAINT PKCarta PRIMARY KEY (Nome)
);




CREATE TABLE IF NOT EXISTS ObjetivoTerritório (
    Descrição INT NOT NULL,
    QtdTerritório INT NOT NULL,
    CONSTRAINT PKObjTerritório PRIMARY KEY (Descrição),
    CONSTRAINT FKObjTerritório FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
);



CREATE TABLE IF NOT EXISTS ObjetivoJogador (
    Descrição INT NOT NULL,
    ExércitoAlvo CHAR(8) NOT NULL,
    CONSTRAINT PKObjJogador PRIMARY KEY (Descrição , ExércitoAlvo),
    CONSTRAINT FKObjJogador FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
);



CREATE TABLE IF NOT EXISTS ObjetivoContinente (
    Descrição INT NOT NULL,
    CONSTRAINT PKObjContinente PRIMARY KEY (Descrição),
    CONSTRAINT FKObjContinente FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
);



CREATE TABLE IF NOT EXISTS Território (
    Nome INT NOT NULL,
    TropasPresentes INT UNSIGNED NOT NULL,
    CONSTRAINT PKTerritório PRIMARY KEY (Nome)
);


CREATE TABLE IF NOT EXISTS Ocupa (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(8) NOT NULL,
    NomeTerritório INT NOT NULL,
    CONSTRAINT PKOcupa PRIMARY KEY (IDUsuário , CorJogador , NomeTerritório),
    CONSTRAINT FK1Ocupa FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2Ocupa FOREIGN KEY (CorJogador)
        REFERENCES Jogador (Cor),
    CONSTRAINT FK3Ocupa FOREIGN KEY (NomeTerritório)
        REFERENCES Território (Nome)
);

CREATE TABLE IF NOT EXISTS Continente (
    Nome VARCHAR(20) NOT NULL,
    QuantidadeDeTerritórios INT UNSIGNED NOT NULL,
    CONSTRAINT PKContinente PRIMARY KEY (Nome)
);



CREATE TABLE IF NOT EXISTS AmigoDe (
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL,
    CONSTRAINT PKAmigoDe
    PRIMARY KEY (IDUsuário1, IDUsuário2),
    CONSTRAINT FK1AmigoDe
    FOREIGN KEY (IDUsuário1) REFERENCES Usuário(ID),
    CONSTRAINT FK2AmigoDe
    FOREIGN KEY (IDUsuário2) REFERENCES Usuário(ID)
);



CREATE TABLE IF NOT EXISTS TrocaMensagens (
    IDUsuário1 INT UNSIGNED NOT NULL,
    IDUsuário2 INT UNSIGNED NOT NULL,
    Texto VARCHAR(240) NOT NULL,
    DataHoraEnvio DATETIME NOT NULL,
    CONSTRAINT PKTrocaMensagens PRIMARY KEY (IDUsuário1 , IDUsuário2 , DataHoraEnvio),
    CONSTRAINT FK1TrocaMensagens FOREIGN KEY (IDUsuário1)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2TrocaMensagens FOREIGN KEY (IDUsuário2)
        REFERENCES Usuário (ID)
);



CREATE TABLE IF NOT EXISTS Participa (
    IDUsuário INT UNSIGNED NOT NULL,
    NomeGrupo VARCHAR(30) NOT NULL,
    CONSTRAINT PKParticipa PRIMARY KEY (IDUsuário),
    CONSTRAINT FK1Participa FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2Participa FOREIGN KEY (NomeGrupo)
        REFERENCES Grupo (Nome)
);



CREATE TABLE IF NOT EXISTS EnviaMSG (
    Texto VARCHAR(240) NOT NULL,
    IDUsuário INT UNSIGNED NOT NULL,
    NomeGrupo VARCHAR(30) NOT NULL,
    DataHoraEnvio DATETIME NOT NULL,
    CONSTRAINT PKEnviaMSG PRIMARY KEY (IDUsuário , NomeGrupo , DataHoraEnvio),
    CONSTRAINT FK1EnviaMSG FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2EnviaMSG FOREIGN KEY (NomeGrupo)
        REFERENCES Grupo (Nome)
);


CREATE TABLE IF NOT EXISTS FazFronteira (
    NomeTerritório1 INT NOT NULL,
    NomeTerritório2 INT NOT NULL,
    CONSTRAINT PKFazFronteira PRIMARY KEY (NomeTerritório1 , NomeTerritório2),
    CONSTRAINT FK1FazFronteira FOREIGN KEY (NomeTerritório1)
        REFERENCES Território (Nome),
    CONSTRAINT FK2FazFronteira FOREIGN KEY (NomeTerritório2)
        REFERENCES Território (Nome)
);



CREATE TABLE IF NOT EXISTS Compõe (
    NomeTerritório INT NOT NULL,
    NomeContinente VARCHAR(20) NOT NULL,
    CONSTRAINT PKCompõe PRIMARY KEY (NomeTerritório),
    CONSTRAINT FK1Compõe FOREIGN KEY (NomeTerritório)
        REFERENCES Território (Nome),
    CONSTRAINT FK2Compõe FOREIGN KEY (NomeContinente)
        REFERENCES Continente (Nome)
);



CREATE TABLE IF NOT EXISTS Conquista (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(8) NOT NULL,
    NomeContinente VARCHAR(20) NOT NULL,
    CONSTRAINT PKConquista PRIMARY KEY (IDUsuário , CorJogador , NomeContinente),
    CONSTRAINT FK1Conquista FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2Conquista FOREIGN KEY (CorJogador)
        REFERENCES Jogador (Cor),
    CONSTRAINT FK3Conquista FOREIGN KEY (NomeContinente)
        REFERENCES Continente (Nome)
);



CREATE TABLE IF NOT EXISTS Joga (
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(8) NOT NULL,
    IDPartida INT UNSIGNED NOT NULL,
    CONSTRAINT PKJoga PRIMARY KEY (IDUsuário , CorJogador , IDPartida),
    CONSTRAINT FK1Joga FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2Joga FOREIGN KEY (CorJogador)
        REFERENCES Jogador (Cor),
    FOREIGN KEY (IDPartida)
        REFERENCES Partida (ID)
);



CREATE TABLE IF NOT EXISTS EliminaJogador (
    IDUsuárioAlvo INT UNSIGNED NOT NULL,
    CorJogadorAlvo CHAR(8) NOT NULL,
    Descrição INT NOT NULL,
    CONSTRAINT PKEliminaJogador PRIMARY KEY (IDUsuárioAlvo , CorJogadorAlvo , Descrição),
    CONSTRAINT FK1EliminaJogador FOREIGN KEY (IDUsuárioAlvo)
        REFERENCES Usuário (ID),
    CONSTRAINT FK2EliminaJogador FOREIGN KEY (CorJogadorAlvo)
        REFERENCES Jogador (Cor),
    CONSTRAINT FK3EliminaJogador FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
);



CREATE TABLE IF NOT EXISTS DominaContinentes (
    Descrição INT NOT NULL,
    NomeContinente VARCHAR(20) NOT NULL,
    CONSTRAINT PKDominaContinentes PRIMARY KEY (Descrição , NomeContinente),
    CONSTRAINT FK1DominaContinentes FOREIGN KEY (NomeContinente)
        REFERENCES Continente (Nome),
    CONSTRAINT FK2DominaContinentes FOREIGN KEY (Descrição)
        REFERENCES Objetivo (Descrição)
);

CREATE TABLE IF NOT EXISTS Possui (
    NomeCarta INT NOT NULL,
    IDUsuário INT UNSIGNED NOT NULL,
    CorJogador CHAR(10) NOT NULL,
    Tipo CHAR(9) NOT NULL,
    CONSTRAINT PKPossui PRIMARY KEY (NomeCarta , IDUsuário , CorJogador),
    CONSTRAINT FK1Possui FOREIGN KEY (NomeCarta)
        REFERENCES Carta (Nome),
    CONSTRAINT FK2Possui FOREIGN KEY (IDUsuário)
        REFERENCES Usuário (ID),
    CONSTRAINT FK3Possui FOREIGN KEY (CorJogador)
        REFERENCES Jogador (Cor),
);