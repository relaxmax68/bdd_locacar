	CREATE TABLE 	DOSSIERS (
	id_dossier		NUMBER(4),
	id_client		NUMBER(4),	
	id_agence_reservation	NUMBER(4),
	id_agence_retour	NUMBER(4),
	num_immatriculation	VARCHAR2(7),
	id_tarif		NUMBER(4),
	date_retrait		DATE DEFAULT SYSDATE CONSTRAINT dos_date_retrait_nn NOT NULL,
	date_retour_prevu	DATE DEFAULT SYSDATE CONSTRAINT dos_date_retour_prevu_nn NOT NULL,
	date_retour_effectif	DATE DEFAULT SYSDATE CONSTRAINT dos_date_retour_effectif_nn NOT NULL,
	km_depart		NUMBER(6) DEFAULT 0 CONSTRAINT dos_km_depart_nn NOT NULL,
	km_arrivee		NUMBER(6) DEFAULT 0 CONSTRAINT dos_km_arrivee_nn NOT NULL,
	assurance_prise		NUMBER(1) DEFAULT 0 CONSTRAINT dos_assurance_prise_nn NOT NULL,
	montant_remise		NUMBER(6) DEFAULT 0,
	pourcentage_remise	NUMBER(3) DEFAULT 0 	
	);


CREATE TABLE	CLIENTS (
	id_client	NUMBER(4),
	id_ville	VARCHAR2(7) DEFAULT 'FR54NAN'  CONSTRAINT clients_id_ville_nn NOT NULL,
	nom		VARCHAR2(25) DEFAULT 'inconnu' CONSTRAINT clients_nom_nn NOT NULL,
	prenom		VARCHAR2(25),
	adresse		VARCHAR2(255)	
	);


CREATE TABLE	VEHICULES (
	num_immatriculation	VARCHAR2(7),
	id_modele		NUMBER(2),
	id_couleur		NUMBER(3),	
	id_agence		NUMBER(4), 
	date_achat		DATE DEFAULT SYSDATE CONSTRAINT vehicules_date_achat_nn NOT NULL,
	km_parcourus	NUMBER(6) DEFAULT 0 CONSTRAINT vehicules_km_parcourus_nn NOT NULL
	);

	
CREATE TABLE	AGENCES (
	id_agence	NUMBER(4),
	id_ville	VARCHAR2(7),
	adresse		VARCHAR2(255),
	num_telephone	VARCHAR2(10),
	nom_responsable	VARCHAR2(50) DEFAULT 'inconnu' CONSTRAINT agences_nom_responsable_nn NOT NULL
	);


CREATE TABLE 	MODELES (
	id_modele	NUMBER(2),
	id_marque	VARCHAR2(7),
	id_categorie	NUMBER(4) DEFAULT 0 CONSTRAINT modeles_categories_id_nn NOT NULL,
	nom		VARCHAR2(20) DEFAULT 'inconnu' CONSTRAINT modeles_nom_nn NOT NULL
	);


CREATE TABLE 	MARQUES (
	id_marque	VARCHAR2(7),
	nom		VARCHAR2(20) DEFAULT 'inconnu' CONSTRAINT marques_nom_nn NOT NULL
	);


CREATE TABLE 	CATEGORIES (
	id_categorie	NUMBER(4),
	nom		VARCHAR2(20),
	capacite	NUMBER(2),
	type_permis	VARCHAR2(2),
	prix_assurance	NUMBER(6,2) 	
	);
	
CREATE TABLE 	TARIFS (
	id_tarif	NUMBER(4),
	id_categorie	NUMBER(4) DEFAULT 0 CONSTRAINT tarifs_categories_id_nn NOT NULL, 
	nom		VARCHAR2(20),
	prix_jour	NUMBER(6,2) DEFAULT 0 CONSTRAINT tarifs_prix_jour_nn NOT NULL,
	prix_forfait	NUMBER(6,2) DEFAULT 0 CONSTRAINT tarifs_prix_forfait_nn NOT NULL,
	km_autorises	NUMBER(6)	DEFAULT 0 CONSTRAINT tarifs_km_autorises_nn NOT NULL,
	prix_km	NUMBER(6,2)	DEFAULT 0 CONSTRAINT tarifs_prix_km_nn NOT NULL
	);

CREATE TABLE	COULEURS (
	id_couleur	NUMBER(4),
	nom	VARCHAR2(20)
	);

CREATE TABLE	PAYS ( 
	id_pays	CHAR(2 BYTE),
	nom 	VARCHAR2(40 BYTE)
	);

CREATE TABLE	VILLES	 ( 
	id_ville	VARCHAR2(7),
	id_pays	CHAR(2 BYTE),
	nom 	VARCHAR2(40 BYTE),
	CP 	VARCHAR2(12 BYTE)
	);

CREATE TABLE	LOC_SUP_SEMAINE	(
	id_dossier 		NUMBER(4),		
	date_du_jour	DATE DEFAULT SYSDATE,
	nom_client		VARCHAR2(25),
	prenom_client	VARCHAR2(25),
	nom_marque		VARCHAR2(20),
	modele 			VARCHAR2(20)
	);


-- Definition des contraintes de CLES PRIMAIRES --

ALTER TABLE DOSSIERS 		ADD CONSTRAINT	dos_id_dossier_pk PRIMARY KEY (id_dossier);
ALTER TABLE CLIENTS 		ADD CONSTRAINT	clients_id_client_pk PRIMARY KEY (id_client);
ALTER TABLE VEHICULES 		ADD CONSTRAINT	vehicules_num_immat_pk PRIMARY KEY (num_immatriculation);
ALTER TABLE AGENCES 		ADD CONSTRAINT	agences_id_agence_pk PRIMARY KEY (id_agence);
ALTER TABLE MODELES 		ADD CONSTRAINT	modeles_id_modele_pk PRIMARY KEY (id_modele);
ALTER TABLE MARQUES 		ADD CONSTRAINT	marques_id_marque_pk PRIMARY KEY (id_marque);
ALTER TABLE CATEGORIES 		ADD CONSTRAINT	categories_id_categorie_pk PRIMARY KEY (id_categorie);
ALTER TABLE TARIFS 			ADD CONSTRAINT	tarifs_id_tarif_pk PRIMARY KEY (id_tarif);
ALTER TABLE COULEURS 		ADD CONSTRAINT	couleurs_id_couleur_pk PRIMARY KEY (id_couleur);
ALTER TABLE PAYS 			ADD CONSTRAINT	pays_id_pays_pk PRIMARY KEY (id_pays);
ALTER TABLE VILLES 			ADD CONSTRAINT	villes_id_ville_pk PRIMARY KEY (id_ville);

-- Definition des contraintes de CLES ETRANGERES --

ALTER TABLE DOSSIERS 	ADD (
	CONSTRAINT	dos_id_client_fk FOREIGN KEY (id_client)
	REFERENCES	CLIENTS(id_client),
	CONSTRAINT	dos_id_ag_res_fk FOREIGN KEY (id_agence_reservation)
	REFERENCES	AGENCES(id_agence),
	CONSTRAINT	dos_id_ag_retour_fk FOREIGN KEY (id_agence_retour)
	REFERENCES	AGENCES(id_agence),
	CONSTRAINT	dos_num_immat_fk FOREIGN KEY (num_immatriculation)
	REFERENCES	VEHICULES(num_immatriculation),
	CONSTRAINT	dos_id_tarif_fk FOREIGN KEY (id_tarif)
	REFERENCES	TARIFS(id_tarif)
	);	
ALTER TABLE CLIENTS 	ADD (
	CONSTRAINT	clients_id_ville_fk	FOREIGN KEY (id_ville)
	REFERENCES	VILLES(id_ville)
	);
ALTER TABLE VEHICULES 	ADD (
	CONSTRAINT	vehicules_id_modele_fk FOREIGN KEY (id_modele)
	REFERENCES	MODELES(id_modele),
	CONSTRAINT	vehicules_id_couleur_fk	FOREIGN KEY (id_couleur)
	REFERENCES	COULEURS(id_couleur),
	CONSTRAINT	vehicules_id_agence_fk	FOREIGN KEY (id_agence)
	REFERENCES	AGENCES(id_agence)
	);
ALTER TABLE AGENCES 	ADD	(
	CONSTRAINT	agences_id_ville_fk	FOREIGN KEY (id_ville)
	REFERENCES	VILLES(id_ville)
	);
ALTER TABLE MODELES 	ADD (
	CONSTRAINT 	modeles_id_marque_fk FOREIGN KEY (id_marque)
	REFERENCES 	MARQUES(id_marque),
	CONSTRAINT	modeles_id_categorie_fk	FOREIGN KEY (id_categorie)
	REFERENCES	CATEGORIES(id_categorie)
	);
ALTER TABLE TARIFS 		ADD (
	CONSTRAINT	tarifs_id_categorie_fk	FOREIGN KEY (id_categorie)
	REFERENCES	CATEGORIES(id_categorie)
	);
ALTER TABLE VILLES 		ADD (	
	CONSTRAINT	villes_id_pays_fk	FOREIGN KEY	(id_pays)
	REFERENCES	PAYS(id_pays)
	);

-- Definition des contraintes de CHECK --

ALTER TABLE DOSSIERS 	ADD (
	CONSTRAINT	chk_dos_ret_theo_sup_retrait CHECK (date_retour_prevu > date_retrait),
	CONSTRAINT	chk_dos_ret_sup_retrait CHECK (date_retour_effectif > date_retrait),
	CONSTRAINT	chk_dos_km_positif CHECK (km_arrivee >= km_depart),
	CONSTRAINT	chk_dos_boolean_assurance CHECK (assurance_prise = 0 or assurance_prise = 1)
	);		
ALTER TABLE CATEGORIES 	ADD (
	CONSTRAINT	chk_cat_prix_assurance_positif	CHECK (prix_assurance >= 0)
	);
ALTER TABLE TARIFS 		ADD (
	CONSTRAINT	chk_tarifs_prix_jour_positif	CHECK (prix_jour >= 0),
	CONSTRAINT	chk_tarifs_prix_km_positif	CHECK (prix_km >= 0)
	);

INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'AR', 'Argentina'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'AU', 'Australia'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'BE', 'Belgium'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'BR', 'Brazil'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'CA', 'Canada'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'CH', 'Switzerland'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'CN', 'China'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'DE', 'Germany'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'DK', 'Denmark'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'EG', 'Egypt'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'FR', 'France'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'HK', 'HongKong'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'IL', 'Israel'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'IN', 'India'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'IR', 'Ireland'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'IT', 'Italy'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'JP', 'Japan'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'KW', 'Kuwait'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'MX', 'Mexico'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'NG', 'Nigeria'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'NL', 'Netherlands'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'SG', 'Singapore'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'UK', 'United Kingdom'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'US', 'United States of America'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'ZM', 'Zambia'); 
INSERT INTO PAYS ( ID_PAYS, NOM ) VALUES ( 'ZW', 'Zimbabwe'); 
COMMIT;

INSERT INTO VILLES ( ID_VILLE, ID_PAYS, NOM, CP ) VALUES ( 'FR54NAN', 'FR', 'Nancy','54000'); 
INSERT INTO VILLES ( ID_VILLE, ID_PAYS, NOM, CP ) VALUES ( 'FR71CSS', 'FR', 'Chalon-sur-Saône','71100'); 
INSERT INTO VILLES ( ID_VILLE, ID_PAYS, NOM, CP ) VALUES ( 'FR21DIJ', 'FR', 'Dijon','21000');
INSERT INTO VILLES ( ID_VILLE, ID_PAYS, NOM, CP ) VALUES ( 'IRD1DUB', 'IR', 'Dublin','D1');
INSERT INTO VILLES ( ID_VILLE, ID_PAYS, NOM, CP ) VALUES ( 'IRD8DUB', 'IR', 'Dublin','D8');
INSERT INTO VILLES ( ID_VILLE, ID_PAYS, NOM, CP ) VALUES ( 'ST67BRG', 'FR', 'Strasbourg','67200');
COMMIT;

INSERT INTO COULEURS ( ID_COULEUR, NOM ) VALUES ( 0, 'NOIR');
INSERT INTO COULEURS ( ID_COULEUR, NOM ) VALUES ( 1, 'BLANC');
INSERT INTO COULEURS ( ID_COULEUR, NOM ) VALUES ( 2, 'GRIS');
INSERT INTO COULEURS ( ID_COULEUR, NOM ) VALUES ( 3, 'BLEU');
INSERT INTO COULEURS ( ID_COULEUR, NOM ) VALUES ( 4, 'ROUGE');
INSERT INTO COULEURS ( ID_COULEUR, NOM ) VALUES ( 5, 'VERT');

INSERT INTO CATEGORIES ( ID_CATEGORIE, NOM, CAPACITE, TYPE_PERMIS, PRIX_ASSURANCE ) 
	VALUES ( 1, 'CITADINE', 5, 'B', 25);
INSERT INTO CATEGORIES ( ID_CATEGORIE, NOM, CAPACITE, TYPE_PERMIS, PRIX_ASSURANCE ) 
	VALUES ( 2, 'BERLINE', 5, 'B', 30);
INSERT INTO CATEGORIES ( ID_CATEGORIE, NOM, CAPACITE, TYPE_PERMIS, PRIX_ASSURANCE ) 
	VALUES ( 3, 'UTILITAIRE', 5, 'B', 30);
INSERT INTO CATEGORIES ( ID_CATEGORIE, NOM, CAPACITE, TYPE_PERMIS, PRIX_ASSURANCE ) 
	VALUES ( 4, 'C1', 4, 'B', 30);
COMMIT;

INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'RNLT', 'RENAULT');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'PGT', 'PEUGEOT');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'VW', 'VOLKSWAGEN');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'CTRN', 'CITROEN');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'FIAT', 'FIAT');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'FORD', 'FORD');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'TOY', 'TOYOTA');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'NSN', 'NISSAN');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'AUDI', 'AUDI');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'MRCDS', 'MERCEDES');
INSERT INTO MARQUES ( ID_MARQUE, NOM ) VALUES ( 'BMW', 'BMW');
COMMIT;

INSERT INTO MODELES ( ID_MODELE, ID_MARQUE, ID_CATEGORIE, NOM) VALUES ( 01, 'RNLT', 1, 'CLIO' );
INSERT INTO MODELES ( ID_MODELE, ID_MARQUE, ID_CATEGORIE, NOM) VALUES ( 02, 'PGT', 1, '106hdi' );
INSERT INTO MODELES ( ID_MODELE, ID_MARQUE, ID_CATEGORIE, NOM) VALUES ( 03, 'PGT', 2, '508' );
INSERT INTO MODELES ( ID_MODELE, ID_MARQUE, ID_CATEGORIE, NOM) VALUES ( 04, 'AUDI', 2, 'A4' );
INSERT INTO MODELES ( ID_MODELE, ID_MARQUE, ID_CATEGORIE, NOM) VALUES ( 05, 'AUDI', 4, 'A1' );
INSERT INTO MODELES ( ID_MODELE, ID_MARQUE, ID_CATEGORIE, NOM) VALUES ( 06, 'RNLT', 3, 'TRAFIC' );
COMMIT;

INSERT INTO AGENCES ( ID_AGENCE, ID_VILLE, ADRESSE, NUM_TELEPHONE, NOM_RESPONSABLE) VALUES ( 1, 'FR54NAN', 'Place Stanislas', '0387654321', 'FRIEH' );
INSERT INTO AGENCES ( ID_AGENCE, ID_VILLE, ADRESSE, NUM_TELEPHONE, NOM_RESPONSABLE) VALUES ( 2, 'IRD8DUB', 'Merrion Square', '0312345678', 'VILAS' );
INSERT INTO AGENCES ( ID_AGENCE, ID_VILLE, ADRESSE, NUM_TELEPHONE, NOM_RESPONSABLE) VALUES ( 3, 'FR71CSS', 'Place Général de Gaulle', '0385234884', 'MARET' );
INSERT INTO AGENCES ( ID_AGENCE, ID_VILLE, ADRESSE, NUM_TELEPHONE, NOM_RESPONSABLE) VALUES ( 4, 'ST67BRG', 'Avenue du Général Leclerc', '0383640803', 'WURST' );
COMMIT;

INSERT INTO VEHICULES ( NUM_IMMATRICULATION, ID_MODELE, ID_COULEUR, ID_AGENCE, DATE_ACHAT, KM_PARCOURUS) VALUES ( 'AM371RR', 2, 0, 2, TO_Date( '09/13/2012 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 50000 );
INSERT INTO VEHICULES ( NUM_IMMATRICULATION, ID_MODELE, ID_COULEUR, ID_AGENCE, DATE_ACHAT, KM_PARCOURUS) VALUES ( 'AM372RR', 5, 4, 1, TO_Date( '06/15/2013 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 45000 );
INSERT INTO VEHICULES ( NUM_IMMATRICULATION, ID_MODELE, ID_COULEUR, ID_AGENCE, DATE_ACHAT, KM_PARCOURUS) VALUES ( 'AM472RR', 6, 3, 3, TO_Date( '07/15/2013 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 80000 );
INSERT INTO VEHICULES ( NUM_IMMATRICULATION, ID_MODELE, ID_COULEUR, ID_AGENCE, DATE_ACHAT, KM_PARCOURUS) VALUES ( 'XM111AL', 1, 1, 1, TO_Date( '01/15/2000 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 80000 );
INSERT INTO VEHICULES ( NUM_IMMATRICULATION, ID_MODELE, ID_COULEUR, ID_AGENCE, DATE_ACHAT, KM_PARCOURUS) VALUES ( 'KK030QQ', 2, 2, 1, TO_Date( '01/15/2000 12:00:00 AM', 'MM/DD/YYYY HH:MI:SS AM'), 87000 );
COMMIT;

INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (1, 1, 'STANDARD_CITADINE', 40, 240, 0, 0.25 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (2, 2, 'STANDARD_BERLINE', 50, 300, 0, 0.50 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (3, 3, 'STANDARD_UTILITAIRE', 45, 270, 0, 0.45 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (4, 1, 'WE_500_CITADINE', 40, 60, 500, 0.35 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (5, 2, 'WE_500_BERLINE', 50, 70, 500, 0.45 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (6, 3, 'WE_500_UTILITAIRE', 45, 80, 500, 0.45 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (7, 1, 'WE_800_CITADINE', 40, 80, 800, 0.45 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (8, 2, 'WE_800_BERLINE', 50, 90, 800, 0.45 );
INSERT INTO TARIFS (ID_TARIF, ID_CATEGORIE, NOM, PRIX_JOUR, PRIX_FORFAIT, KM_AUTORISES, PRIX_KM) VALUES (9, 3, 'WE_800_UTILITAIRE', 45, 100, 800, 0.45 );
COMMIT;
INSERT INTO CLIENTS (ID_CLIENT, ID_VILLE, NOM, PRENOM, ADRESSE) VALUES (1, 'FR54NAN', 'FRIEH', 'REMI', '14 les chataigners');
INSERT INTO CLIENTS (ID_CLIENT, ID_VILLE, NOM, PRENOM, ADRESSE) VALUES (2, 'FR71CSS', 'VILAS', 'ANNE', '47 rue Gal GIRAUD');
COMMIT;

INSERT INTO DOSSIERS (ID_DOSSIER, ID_CLIENT, ID_AGENCE_RESERVATION, ID_AGENCE_RETOUR, NUM_IMMATRICULATION, ID_TARIF, DATE_RETRAIT, DATE_RETOUR_PREVU, DATE_RETOUR_EFFECTIF, KM_DEPART, KM_ARRIVEE, ASSURANCE_PRISE) 
	VALUES (1, 1, 1, 4, 'AM372RR', 2, TO_Date( '10/10/2008', 'MM/DD/YYYY'), TO_Date( '10/18/2008', 'MM/DD/YYYY'), TO_Date( '10/18/2008', 'MM/DD/YYYY'), 45000, 45200, 1 );
INSERT INTO DOSSIERS (ID_DOSSIER, ID_CLIENT, ID_AGENCE_RESERVATION, ID_AGENCE_RETOUR, NUM_IMMATRICULATION, ID_TARIF, DATE_RETRAIT, DATE_RETOUR_PREVU, DATE_RETOUR_EFFECTIF, KM_DEPART, KM_ARRIVEE, ASSURANCE_PRISE) 
	VALUES (2, 2, 3, 3, 'AM472RR', 3, TO_Date( '11/10/2013', 'MM/DD/YYYY'), TO_Date( '11/13/2013', 'MM/DD/YYYY'), TO_Date( '12/13/2013', 'MM/DD/YYYY'), 80000, 80500, 1 );
INSERT INTO DOSSIERS (ID_DOSSIER, ID_CLIENT, ID_AGENCE_RESERVATION, ID_AGENCE_RETOUR, NUM_IMMATRICULATION, ID_TARIF, DATE_RETRAIT, DATE_RETOUR_PREVU, DATE_RETOUR_EFFECTIF, KM_DEPART, KM_ARRIVEE, ASSURANCE_PRISE,montant_remise,pourcentage_remise) 
	VALUES (3, 1, 1, 4, 'AM372RR', 2, TO_Date( '10/30/2011', 'MM/DD/YYYY'), TO_Date( '11/02/2011', 'MM/DD/YYYY'), TO_Date( '11/02/2011', 'MM/DD/YYYY'), 50000, 50700, 1 ,0,10);
INSERT INTO DOSSIERS (ID_DOSSIER, ID_CLIENT, ID_AGENCE_RESERVATION, ID_AGENCE_RETOUR, NUM_IMMATRICULATION, ID_TARIF, DATE_RETRAIT, DATE_RETOUR_PREVU, DATE_RETOUR_EFFECTIF, KM_DEPART, KM_ARRIVEE, ASSURANCE_PRISE,montant_remise,pourcentage_remise) 
	VALUES (4, 1, 1, 4, 'KK030QQ', 2, TO_Date( '09/28/2008', 'MM/DD/YYYY'), TO_Date( '10/03/2008', 'MM/DD/YYYY'), TO_Date( '10/03/2008', 'MM/DD/YYYY'), 87000, 87800, 1 ,20 ,0);
INSERT INTO DOSSIERS (ID_DOSSIER, ID_CLIENT, ID_AGENCE_RESERVATION, ID_AGENCE_RETOUR, NUM_IMMATRICULATION, ID_TARIF, DATE_RETRAIT, DATE_RETOUR_PREVU, DATE_RETOUR_EFFECTIF, KM_DEPART, KM_ARRIVEE, ASSURANCE_PRISE,montant_remise,pourcentage_remise) 
	VALUES (5, 2, 1, 1, 'XM111AL', 2, TO_Date( '01/15/2014', 'MM/DD/YYYY'), TO_Date( '02/15/2014', 'MM/DD/YYYY'), TO_Date( '02/15/2014', 'MM/DD/YYYY'), 80000, 80150, 0, 0, 0);

