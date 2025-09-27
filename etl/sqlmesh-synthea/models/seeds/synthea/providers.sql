MODEL (
  name synthea.providers,
  kind SEED (
    path '$root/../../data/syntheaRaw/providers.csv'
  ),
  columns (
    Id TEXT,
    ORGANIZATION TEXT,
    NAME TEXT,
    GENDER TEXT,
    SPECIALITY TEXT,
    ADDRESS TEXT,
    CITY TEXT,
    STATE TEXT,
    ZIP TEXT,
    LAT DOUBLE,
    LON DOUBLE,
    ENCOUNTERS INTEGER,
    PROCEDURES INTEGER
  )
)
