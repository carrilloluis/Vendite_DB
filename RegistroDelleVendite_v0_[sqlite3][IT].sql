/*
@description Registro delle vendite dei articoli per picoli negozzi
@author Luis Carrillo Gutiérrez
@version 0.0.1
*/

DROP TABLE IF EXISTS [Categorie];
CREATE TABLE IF NOT EXISTS [Categorie]
(
	[id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, -- Identificativo univoco
	[nome] VARCHAR(32) NOT NULL,
	[descrizione] TEXT NULL -- Descrizione dettagliata
); -- WITHOUT RowId;

DROP TABLE IF EXISTS [Prodotti];
CREATE TABLE IF NOT EXISTS [Prodotti]
(
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nome VARCHAR(32) NOT NULL,
	descrizione TEXT NULL
); -- WITHOUT RowId;

DROP TABLE IF EXISTS [CategoriePerProdotti];
CREATE TABLE IF NOT EXISTS [CategoriePerProdotti]
(
	idProdotto INTEGER NOT NULL REFERENCES [Prodotti](id),
	idCategoria INTEGER NOT NULL REFERENCES [Categorie](id),
	PRIMARY KEY (idProdotto, idCategoria)
) WITHOUT RowId;

DROP TABLE IF EXISTS [Fornitori];
CREATE TABLE IF NOT EXISTS [Fornitori]
(
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nome VARCHAR(128) NOT NULL
); -- WITHOUT RowId;


DROP TABLE IF EXISTS [MagazziniMerci];
CREATE TABLE IF NOT EXISTS [MagazziniMerci]
(
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	nomeNegozio VARCHAR(64) NOT NULL, 
	descrizione TEXT NULL,
	direzione VARCHAR(64) NOT NULL  -- luogo
);

-- articolo di magazzino / articolo nell'inventario
DROP TABLE IF EXISTS [ArticoliNellInventario];
CREATE TABLE IF NOT EXISTS [ArticoliNellInventario] -- stock item
(
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	-- codice
	UnitáDiVendita VARCHAR(8) NOT NULL DEFAULT 'PKG', -- pacchetto
	idProdotto INTEGER NOT NULL REFERENCES [Prodotti](id),
	idFornitore INTEGER NOT NULL REFERENCES [Fornitori](id),
	KEY [idProdotto, idFornitore]
); -- WITHOUT RowId;

DROP TABLE IF EXISTS [Inventari];
CREATE TABLE IF NOT EXISTS [Inventari]
(
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	-- Identificazione di compra
	idAcquisto INTEGER NOT NULL, -- REFERENCES [AcquistoDaFornitori](id)
	idArticoloNellInventario INTEGER NOT NULL REFERENCES [ArticoliNellInventario](id),
	quantita DECIMAL(10, 3) DEFAULT 1.00,
    dataDiIngresso DATETIME DEFAULT CURRENT_TIMESTAMP -- Data creazione
); -- WITHOUT RowId;

DROP TABLE IF EXISTS [TransazioneDiVendita];
CREATE TABLE IF NOT EXISTS [TransazioneDiVendita]
(
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	-- Identificazione di vendita
	idVendita INTEGER NOT NULL, -- REFERENCES [VenditaAiClienti](id)
	idArticoloNellInventario INTEGER NOT NULL REFERENCES [ArticoliNellInventario](id),
	quantita DECIMAL(10, 3) DEFAULT 1.00,
	dataDiUscita DATETIME DEFAULT CURRENT_TIMESTAMP
); -- WITHOUT RowId;
