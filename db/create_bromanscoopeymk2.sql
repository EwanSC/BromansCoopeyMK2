DROP TABLE IF EXISTS material;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS inscribed_monument;
DROP TABLE IF EXISTS small_find_artefact;
DROP TABLE IF EXISTS corpus;
DROP TABLE IF EXISTS material_corpus;
DROP TABLE IF EXISTS monument_serviceman;
DROP TABLE IF EXISTS legio_serviceman;
DROP TABLE IF EXISTS military_status;
DROP TABLE IF EXISTS unit;

CREATE TABLE inscribed_monument (
	MonumentID INTEGER PRIMARY KEY,
	MonumentType TEXT,
	MentionsUnit TEXT,
	Inscription TEXT,
	CleanedInscription TEXT,
	Translation TEXT,
	TranslationSource TEXT,
	Decorated TEXT,
	Pediment TEXT,
	PedimentDetail TEXT,
	Frieze TEXT,
	Portrait TEXT,
	InscriptionDetails TEXT,
	LowerFieldDecoration TEXT,
	LowerFieldDetail TEXT,
	MonumentStyleType TEXT
);

-- SELECT *
--   FROM monument JOIN inscribed_monument USING (monumentID);

select 'inscribedmonumentsloaded', count(*) from inscribed_monument;

UPDATE inscribed_monument SET MonumentID = NULL WHERE MonumentID = '';
UPDATE inscribed_monument SET MonumentType = NULL WHERE MonumentType = '';
UPDATE inscribed_monument SET Inscription = NULL WHERE Inscription = '';
UPDATE inscribed_monument SET CleanedInscription = NULL WHERE CleanedInscription = '';
UPDATE inscribed_monument SET Translation = NULL WHERE Translation = '';
UPDATE inscribed_monument SET TranslationSource = NULL WHERE TranslationSource = '';
UPDATE inscribed_monument SET Decorated = NULL WHERE Decorated = '';
UPDATE inscribed_monument SET LowerFieldDecoration = NULL WHERE LowerFieldDecoration = '';
UPDATE inscribed_monument SET LowerFieldDetail = NULL WHERE LowerFieldDetail = '';
UPDATE inscribed_monument SET Portrait = NULL WHERE Portrait = '';
UPDATE inscribed_monument SET Frieze = NULL WHERE Frieze = '';
UPDATE inscribed_monument SET MonumentStyleType = NULL WHERE MonumentStyleType = '';


CREATE TABLE small_find_artefact (
	ArtefactID INTEGER PRIMARY KEY,
	ArtefactType TEXT,
	ArtefactStyle TEXT,
	ArtefactTypologyType TEXT,
	ExcavationReport TEXT,
	Description TEXT,
	Gendered TEXT,
	Military TEXT,
	SmallInscription TEXT,
	CleanedSmallInscription TEXT,
	SmallInscriptionTranslation TEXT,
	SmallInscriptionTranslationSource TEXT
);

select 'smallfindmonumentsloaded', count(*) from small_find_artefact;

UPDATE small_find_artefact SET ArtefactID = NULL WHERE ArtefactID = '';
UPDATE small_find_artefact SET ArtefactType = NULL WHERE ArtefactType = '';
UPDATE small_find_artefact SET ArtefactStyle = NULL WHERE ArtefactStyle = '';
UPDATE small_find_artefact SET ArtefactTypologyType = NULL WHERE ArtefactTypologyType = '';
UPDATE small_find_artefact SET ExcavationReport = NULL WHERE ExcavationReport = '';
UPDATE small_find_artefact SET Description = NULL WHERE Description = '';
UPDATE small_find_artefact SET Gendered = NULL WHERE Gendered = '';
UPDATE small_find_artefact SET Military = NULL WHERE Military = '';
UPDATE small_find_artefact SET SmallInscription = NULL WHERE SmallInscription = '';
UPDATE small_find_artefact SET CleanedSmallInscription = NULL WHERE CleanedSmallInscription = '';
UPDATE small_find_artefact SET SmallInscriptionTranslation = NULL WHERE SmallInscriptionTranslation = '';
UPDATE small_find_artefact SET SmallInscriptionTranslationSource = NULL WHERE SmallInscriptionTranslationSource = '';


CREATE TABLE location (
	LocationID INTEGER PRIMARY KEY,
	RomanProvince TEXT,
	AncientSite TEXT,
	SpecificAncientLocation TEXT,
	ModernSite TEXT,
	SpecificModernLocation TEXT,
	ExtraLocationNote TEXT,
	LONGITUDE_epsg_4326 NUMBER,
	LATITUDE_epsg_4326 NUMBER,
	Pleiades TEXT,
	Trismegistos TEXT
);

-- .mode csv
-- .import ../original_source_data/location.csv location

UPDATE location SET RomanProvince = NULL WHERE RomanProvince = '';
UPDATE location SET AncientSite = NULL WHERE AncientSite = '';
UPDATE location SET SpecificAncientLocation = NULL WHERE SpecificAncientLocation = '';
UPDATE location SET ModernSite = NULL WHERE ModernSite = '';
UPDATE location SET SpecificModernLocation = NULL WHERE SpecificModernLocation = '';
UPDATE location SET ExtraLocationNote = NULL WHERE ExtraLocationNote = '';
UPDATE location SET LONGITUDE_epsg_4326 = NULL WHERE LONGITUDE_epsg_4326 = '';
UPDATE location SET LATITUDE_epsg_4326 = NULL WHERE LATITUDE_epsg_4326 = '';
UPDATE location SET Pleiades = NULL WHERE Pleiades = '';
UPDATE location SET Trismegistos = NULL WHERE Trismegistos = '';

select 'locationsloaded', count(*) from location;


CREATE TABLE material (
	MaterialID INTEGER PRIMARY KEY,
	ArtefactID INTEGER REFERENCES small_find_artefact,
	MonumentID INTEGER REFERENCES inscribed_monument,
	LocationID INTEGER REFERENCES location,
	Findspot TEXT,
	FindspotCertainty TEXT,
	FindspotChecked TEXT,
	DateFrom INTEGER, -- INTEGER YEAR - years are BCE
	DateTo INTEGER, -- INTEGER YEAR - years are BCE
	DateNote TEXT,
	ModernHolding TEXT,
	HoldingData TEXT,
	MaterialNote TEXT,
	DBInclusionReason TEXT,
	Media TEXT
);

select 'materialoaded', count(*) from material;

UPDATE material SET MaterialID = NULL WHERE MaterialID = '';
UPDATE material SET MonumentID = NULL WHERE MonumentID = '';
UPDATE material SET ArtefactID = NULL WHERE ArtefactID = '';
UPDATE material SET LocationID = NULL WHERE LocationID = '';
UPDATE material SET Findspot = NULL WHERE Findspot = '';
UPDATE material SET FindspotCertainty = NULL WHERE FindspotCertainty = '';
UPDATE material SET FindspotChecked = NULL WHERE FindspotChecked = '';
UPDATE material SET DateFrom = NULL WHERE DateFrom = '';
UPDATE material SET DateTo = NULL WHERE DateTo = '';
UPDATE material SET DateNote = NULL WHERE DateNote = '';
UPDATE material SET ModernHolding = NULL WHERE ModernHolding = '';
UPDATE material SET HoldingData = NULL WHERE HoldingData = '';
UPDATE material SET MaterialNote = NULL WHERE MaterialNote = '';
UPDATE material SET DBInclusionReason = NULL WHERE DBInclusionReason = '';
UPDATE material SET Media = NULL WHERE Media = '';

-- .mode csv
-- .import ../original_source_data/monument.csv monument


CREATE TABLE corpus (
	CorpusName TEXT PRIMARY KEY
);

--.mode csv
--.import ../original_source_data/corpus.csv corpus

select 'corpusloaded', count(*) from corpus;


CREATE TABLE material_corpus (
  MaterialCorpusID INTEGER PRIMARY KEY,
	MaterialID INTEGER REFERENCES material NOT NULL,
	CorpusName TEXT NOT NULL REFERENCES corpus,
	Reference TEXT NOT NULL,
	isPrimaryReference TEXT
);

-- .mode csv
-- .import ../original_source_data/material_corpus.csv material_corpus

select 'referencesloaded', count(*) from material_corpus;

UPDATE material_corpus SET isPrimaryReference = NULL WHERE isPrimaryReference = '';

CREATE TABLE monument_serviceman (
	  MonumentServicemanID NUMBER PRIMARY KEY,
		ServicemanID INTEGER REFERENCES legio_serviceman,
		MonumentID INTEGER REFERENCES inscribed_monument,
		ServicemanReferencedAs TEXT,
		PossibleDuplicateServicemanID INTEGER,
		SourceForDuplicateArgument TEXT
);

-- ServicemanReferencedAs refers to how Serviceman is referred to: either AS commemorator,
-- commemorated, both (erected during lifetime), administrator, or dedicant (sacral inscriptions)
-- PossibleDuplicateServicemanID records the ServicemanID of the individual which may be a duplicate of this certain MaterialID

-- .mode csv
-- .import ../original_source_data/monument_serviceman.csv monument_serviceman

select 'monumentservicemenloaded', count(*) from monument_serviceman;

UPDATE monument_serviceman SET ServicemanReferencedAs = NULL WHERE ServicemanReferencedAs = '';
UPDATE monument_serviceman SET PossibleDuplicateServicemanID = NULL WHERE PossibleDuplicateServicemanID = '';
UPDATE monument_serviceman SET SourceForDuplicateArgument = NULL WHERE SourceForDuplicateArgument = '';


CREATE TABLE unit (
	UnitID INTEGER PRIMARY KEY,
	UnitTitle TEXT
);

-- .mode csv
-- .import ../original_source_data/unit.csv unit

select 'unitsloaded', count(*) from unit;

CREATE TABLE military_status (
	MilitaryStatusID INTEGER PRIMARY KEY,
	FirstRecordedOffice TEXT,
 	SecondRecordedOffice TEXT,
	FirstOfficeCertainty TEXT,
	SecondOfficeCertainty TEXT,
	VeteranStatus TEXT,
	VeteranStatusCertainty TEXT
);

-- .mode csv
-- .import ../original_source_data/military_status.csv military_status

select 'officesloaded', count(*) from military_status;

UPDATE military_status SET FirstRecordedOffice = NULL WHERE FirstRecordedOffice = '';
UPDATE military_status SET SecondRecordedOffice = NULL WHERE SecondRecordedOffice = '';
UPDATE military_status SET FirstOfficeCertainty = NULL WHERE FirstOfficeCertainty = '';
UPDATE military_status SET SecondOfficeCertainty = NULL WHERE SecondOfficeCertainty = '';
UPDATE military_status SET VeteranStatus = NULL WHERE VeteranStatus = '';
UPDATE military_status SET VeteranStatusCertainty = NULL WHERE VeteranStatusCertainty = '';

CREATE TABLE legio_serviceman (
  ServicemanID INTEGER PRIMARY KEY,
	Name TEXT,
	DefiniteServiceman TEXT,
	UnitID INTEGER REFERENCES unit,
	LiklihoodOfUnitAttribution TEXT,
  MilitaryStatusID INTEGER REFERENCES military_status,
	Tribe TEXT,
	OriginProvince TEXT,
	OriginSettlement TEXT,
	OriginCertainty TEXT,
	TribeSettlementNote TEXT,
	ServicemanNote TEXT
);
-- 'ServicemanID' is used to refer to the Legio VII serviceman recorded upon the inscription. There can be multiple per MaterialID
-- DefiniteServiceman refers to whether or not they were a soldier/milites, not necessarily Legio VII. For that, see .monument

-- .mode csv
-- .import ../original_source_data/legio_serviceman.csv legio_serviceman

select 'legionariesloaded', count(*) from legio_serviceman;

UPDATE legio_serviceman SET Name = NULL WHERE Name = '';
UPDATE legio_serviceman SET DefiniteServiceman = NULL WHERE DefiniteServiceman = '';
UPDATE legio_serviceman SET UnitID = NULL WHERE UnitID = '';
UPDATE legio_serviceman SET LiklihoodOfUnitAttribution = NULL WHERE LiklihoodOfUnitAttribution = '';
UPDATE legio_serviceman SET Tribe = NULL WHERE Tribe = '';
UPDATE legio_serviceman SET MilitaryStatusID = NULL WHERE MilitaryStatusID = '';
UPDATE legio_serviceman SET OriginProvince = NULL WHERE OriginProvince = '';
UPDATE legio_serviceman SET OriginSettlement = NULL WHERE OriginSettlement = '';
UPDATE legio_serviceman SET OriginCertainty = NULL WHERE OriginCertainty = '';
UPDATE legio_serviceman SET ServicemanNote = NULL WHERE ServicemanNote = '';
UPDATE legio_serviceman SET TribeSettlementNote = NULL WHERE TribeSettlementNote = '';

-- Below are the various views created so that some information from various tables can be found in the same view
DROP VIEW IF EXISTS all_material_with_location;
CREATE VIEW all_material_with_location AS
SELECT
	MaterialID,
	MonumentID,
	ArtefactID,
	CorpusName ||' ' || Reference AS 'Reference',
	MentionsUnit AS 'Mentions_Roman_Unit',
	ArtefactType,
	ArtefactStyle,
	ArtefactTypologyType,
	MonumentType,
	Inscription,
	Translation,
	TranslationSource AS 'Source_of_Translation',
	MonumentStyleType AS 'MonumentStyleType_Style_Type',
	LowerFieldDecoration || (coalesce(', '|| LowerFieldDetail, '')) AS 'Lower_Field_Decoration',
	Portrait,
	Frieze,
	DateFrom ||' to '||	DateTo AS 'Date',
	DateNote,
	ModernHolding ||(coalesce(', '|| HoldingData, '')) AS 'Current_Location',
	RomanProvince AS 'Roman_Province',
	AncientSite AS 'Ancient_Site',
	SpecificAncientLocation AS 'Specific_Provenience',
	ModernSite AS 'Modern_Find_Site',
	SpecificModernLocation 'Modern_Provenience',
	ExtraLocationNote AS 'General_Location_Note',
	Findspot AS 'Material_Provenience_Note',
	LATITUDE_epsg_4326 AS 'LAT',
	LONGITUDE_epsg_4326 AS 'LONG',
	Pleiades,
	Trismegistos,
	MaterialNote,
	DBInclusionReason,
	Media
	FROM material
			JOIN location USING (LocationID)
			JOIN inscribed_monument USING (MonumentID)
			JOIN small_find_artefact USING (ArtefactID)
			JOIN material_corpus USING (MaterialID)
						WHERE isPrimaryReference IS NOT NULL
