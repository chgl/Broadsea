-- remove any previously added database connection configuration data
truncate ohdsi.source;
truncate ohdsi.source_daimon;

-- OHDSI CDM source
INSERT INTO ohdsi.source( source_id, source_name, source_key, source_connection, source_dialect)
VALUES (1, 'OHDSI CDM V5 Database', 'OHDSI-CDMV5',
  'jdbc:sqlserver://omop-db;database=ohdsi;user=sa;password=strong_ohdsi_password', 'sql server');

-- CDM daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1, 1, 0, 'dbo', 2);

-- VOCABULARY daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2, 1, 1, 'dbo', 2);

-- RESULTS daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3, 1, 2, 'ohdsi', 2);

-- EVIDENCE daimon
INSERT INTO ohdsi.source_daimon( source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (4, 1, 3, 'ohdsi', 2);
