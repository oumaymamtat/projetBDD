CREATE TABLE Client (
   idClient DECIMAL(5) NOT NULL,
   NomClient varchar(255), 
   PrenomClient varchar(255),
   dateNaissClient date, 
   NumTel varchar(255),
   AdresseClient varchar(255),
   primeFidelite float,
   PRIMARY KEY (idClient)
);

CREATE TABLE Parrainage (
   idClientParrain int NOT NULL,
   idClientFilleul int NOT NULL,
   interetAnnuel float,
   PRIMARY KEY (idClientParrain,idClientFilleul),
   CONSTRAINT FK_CClientParrain FOREIGN KEY (idClientParrain) REFERENCES Client(idClient),
   CONSTRAINT FK_CClientFilleul FOREIGN KEY (idClientFilleul) REFERENCES Client(idClient)
);

CREATE TABLE Agence (
   idAgence int NOT NULL,
   AdresseAgence varchar(255),
   PRIMARY KEY (idAgence)
);




CREATE TABLE Compte (
   idCompte int NOT NULL,
   MontantCompte float,
   TypeCompte varchar(255),
   idAgence int,
   idClient int,
   PRIMARY KEY (idCompte),
   CONSTRAINT FK_CompteAgence FOREIGN KEY (idAgence) REFERENCES Agence (idAgence),
   CONSTRAINT FK_CompteClient FOREIGN KEY (idClient) REFERENCES Client (idClient),
   CONSTRAINT chk_TypeCompte CHECK (TypeCompte IN ('epargne', 'devise', 'courant'))
);

CREATE TABLE CompteEpargne (
   idCompteEpargne int NOT NULL,
   interetAnnuel float,
   PRIMARY KEY (idCompteEpargne),
   CONSTRAINT FK_CCompteEpargne FOREIGN KEY (idCompteEpargne) REFERENCES Compte(idCompte)
);

CREATE TABLE CompteDevise (
   idCompteDevise int NOT NULL,
   FluxTransaction float,
   PRIMARY KEY (idCompteDevise),
   CONSTRAINT FK_CCompteDevise FOREIGN KEY (idCompteDevise) REFERENCES Compte(idCompte)
);




CREATE TABLE CompteCourant (
   idCompteCourant int NOT NULL,
   Solde float,
   PRIMARY KEY (idCompteCourant),
   CONSTRAINT FK_CCompteCourant FOREIGN KEY (idCompteCourant) REFERENCES Compte(idCompte)
);

CREATE TABLE Pret (
   idPret int NOT NULL,
   TypePret varchar(255),
   MontantPret float, 
   NbEchePret int, 
   DatePret date,
   idClient int,
   PRIMARY KEY (idPret),
   CONSTRAINT FK_PretClient FOREIGN KEY (idClient) REFERENCES Client(idClient)
);

CREATE TABLE Transaction (
   idTransaction int NOT NULL,
   TypeTransaction varchar(255),
   MontantTransaction varchar(255),
   idClient int,
   idCompte int,
   PRIMARY KEY (idTransaction),
   CONSTRAINT FK_TransactionClient FOREIGN KEY (idClient) REFERENCES Client(idClient),
   CONSTRAINT FK_TransactionCompte FOREIGN KEY (idCompte) REFERENCES Compte(idCompte),
  CONSTRAINT chk_TypeTransaction CHECK (TypeTransaction IN ('depot', 'retrait', 'virement', 'transfert'))
);

CREATE TABLE Cheque (
   idCheque int NOT NULL,
   DateCheque date,
   idClient int,
   PRIMARY KEY (idCheque),
   CONSTRAINT FK_ClientCheque FOREIGN KEY (idClient) REFERENCES Client(idClient)
);

CREATE TABLE Carte (
   idCarte int NOT NULL,
   DateExpCarte date,
   idClient int,
   idCompte int,
   PRIMARY KEY (idCarte),
   CONSTRAINT FK_CarteClient FOREIGN KEY (idClient) REFERENCES Client(idClient),
   CONSTRAINT FK_CarteCompte FOREIGN KEY (idCompte) REFERENCES Compte(idCompte)
);

CREATE TABLE Service (
   idService int NOT NULL,
   TypeService varchar(255),
   MontantService float,
   idClient int,
   PRIMARY KEY (idService),
   CONSTRAINT FK_ServiceClient FOREIGN KEY (idClient) REFERENCES Client(idClient),
   CONSTRAINT chk_TypeService CHECK (TypeService IN ('ouverture', 'cloture'))
);

