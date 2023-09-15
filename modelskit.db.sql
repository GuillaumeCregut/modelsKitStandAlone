BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "country" (
	"id"	INTEGER NOT NULL,
	"name"	VARCHAR(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "brand" (
	"id"	INTEGER NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "category" (
	"id"	INTEGER NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "period" (
	"id"	INTEGER NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "scale" (
	"id"	INTEGER NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "state" (
	"id"	INTEGER NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "builder" (
	"id"	INTEGER NOT NULL,
	"country"	INTEGER NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("country") REFERENCES "country"("id")
);
CREATE TABLE IF NOT EXISTS "model" (
	"id"	INTEGER NOT NULL,
	"brand"	INTEGER NOT NULL,
	"builder"	INTEGER NOT NULL,
	"category"	INTEGER NOT NULL,
	"period"	INTEGER NOT NULL,
	"scale"	INTEGER NOT NULL,
	"name"	varchar(255) NOT NULL,
	"reference"	varchar(255),
	"picture"	varchar(255),
	"scalemates"	varchar(255),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("builder") REFERENCES "builder"("id"),
	FOREIGN KEY("category") REFERENCES "category"("id"),
	FOREIGN KEY("scale") REFERENCES "scale"("id"),
	FOREIGN KEY("brand") REFERENCES "brand"("id"),
	FOREIGN KEY("period") REFERENCES "period"("id")
);
CREATE TABLE IF NOT EXISTS "model_user" (
	"id"	INTEGER NOT NULL,
	"state"	INTEGER NOT NULL,
	"model"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("state") REFERENCES "state"("id"),
	FOREIGN KEY("model") REFERENCES "model"("id")
);
INSERT INTO "country" ("id","name") VALUES (1,'France'),
 (2,'Allemagne'),
 (3,'U.S.A'),
 (4,'U.R.S.S'),
 (5,'Japon'),
 (6,'Angleterre'),
 (7,'Italie'),
 (8,'Tchecoslovaquie'),
 (9,'Hollande'),
 (10,'Aucun');
INSERT INTO "brand" ("id","name") VALUES (1,'Academy'),
 (2,'Airfix'),
 (3,'Tamiya'),
 (4,'Eduard'),
 (5,'Hasegawa'),
 (6,'Hobby Boss'),
 (7,'ICM'),
 (8,'Italeri'),
 (9,'Meng'),
 (10,'Monogram'),
 (11,'Revell'),
 (12,'Special Hobby'),
 (13,'Trumpeter'),
 (14,'Zvezda'),
 (15,'Meng'),
 (16,'Roden'),
 (17,'Sword'),
 (18,'MiniArt'),
 (19,'Fine Molds'),
 (20,'AFV Club');
INSERT INTO "category" ("id","name") VALUES (1,'Avions'),
 (2,'Blindés'),
 (3,'Hélicoptères'),
 (4,'Navires'),
 (5,'Véhicules');
INSERT INTO "period" ("id","name") VALUES (1,'Guerre de Corée'),
 (2,'Entre guerres'),
 (3,'Moderne'),
 (4,'WWI'),
 (5,'Vietnam'),
 (6,'WWII');
INSERT INTO "scale" ("id","name") VALUES (1,'1/24'),
 (2,'1/35'),
 (3,'1/48'),
 (4,'1/72'),
 (5,'1/32');
INSERT INTO "state" ("id","name") VALUES (1,'En stock'),
 (2,'En cours'),
 (3,'Terminé'),
 (4,'Liste de souhaits'),
 (5,'Commandé');
COMMIT;
