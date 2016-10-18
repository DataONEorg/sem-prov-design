
The following SQL statements are used to create the R `recordr` package
database.

```
-- Table: admin
CREATE TABLE admin (
    id      INTEGER PRIMARY KEY,
    version TEXT    NOT NULL,
    UNIQUE ( version )
);


-- Table: execmeta
CREATE TABLE execmeta (
    seq                 INTEGER PRIMARY KEY,
    executionId         TEXT    NOT NULL,
    metadataId          TEXT,
    datapackageId       TEXT,
    user                TEXT,
    subject             TEXT,
    hostId              TEXT,
    startTime           TEXT,
    operatingSystem     TEXT,
    runtime             TEXT,
    softwareApplication TEXT,
    moduleDependencies  TEXT,
    endTime             TEXT,
    errorMessage        TEXT,
    publishTime         TEXT,
    publishNodeId       TEXT,
    publishId           TEXT,
    console             INTEGER,
    UNIQUE ( executionId )
);


-- Table: tags
CREATE TABLE tags (
    seq         INTEGER PRIMARY KEY,
    executionId TEXT    NOT NULL,
    tag         TEXT    NOT NULL,
    UNIQUE ( executionId, tag )  ON CONFLICT IGNORE,
    FOREIGN KEY ( executionId ) REFERENCES execmeta ( executionId ) ON DELETE CASCADE
);


-- Table: filemeta
CREATE TABLE filemeta (
    fileId           TEXT    PRIMARY KEY,
    executionId      TEXT    NOT NULL,
    filePath         TEXT    NOT NULL,
    sha256           TEXT    NOT NULL,
    size             INTEGER NOT NULL,
    user             TEXT    NOT NULL,
    modifyTime       TEXT    NOT NULL,
    createTime       TEXT    NOT NULL,
    access           TEXT    NOT NULL,
    format           TEXT,
    archivedFilePath TEXT,
    FOREIGN KEY ( executionId ) REFERENCES execmeta ( executionId ),
    UNIQUE ( fileId )
);


-- Table: provenance
CREATE TABLE provenance (
    executionId TEXT NOT NULL,
    subject     TEXT NOT NULL,
    predicate   TEXT NOT NULL,
    object      TEXT NOT NULL,
    subjectType TEXT,
    objectType  TEXT,
    dataTypeURI TEXT,
    FOREIGN KEY ( executionId ) REFERENCES execmeta ( executionId )
);
```
