set -euo pipefail

mkdir -p ../data

sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM material ORDER BY MaterialID' > ../data/material.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM inscribed_monument ORDER BY MonumentID' ../data/inscribed_monument.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM small_find_artfact ORDER BY ArtefactID' ../data/small_find_artfact.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM location ORDER BY LocationID' > ../data/location.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM corpus ORDER BY CorpusName;' > ../data/corpus.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM material_corpus ORDER BY MaterialCorpusID' > ../data/monument_corpus.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM monument_serviceman ORDER BY MonumentServicemanID' > ../data/monument_serviceman.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM legio_serviceman ORDER BY ServicemanID' > ../data/legio_serviceman.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM military_status ORDER BY MilitaryStatusID' > ../data/military_status.csv
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM unit ORDER BY UnitID' > ../data/unit.csv


mkdir -p ../analysis
sqlite3 BromansDBmk2.db -csv -header 'SELECT * FROM all_material_with_location' > ../analysis/all_material_with_location.csv
