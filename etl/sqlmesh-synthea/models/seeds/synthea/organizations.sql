MODEL (
  name synthea.organizations,
  kind SEED (
    path '$root/../../data/syntheaRaw/organizations.csv'
  ),
  columns (
    Id TEXT,
    NAME TEXT,
    ADDRESS TEXT,
    CITY TEXT,
    STATE TEXT,
    ZIP TEXT,
    LAT DOUBLE,
    LON DOUBLE,
    PHONE TEXT,
    REVENUE DOUBLE,
    UTILIZATION DOUBLE
  )
)
