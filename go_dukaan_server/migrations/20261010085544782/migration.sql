BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "purchase_items" (
    "id" bigserial PRIMARY KEY,
    "purchaseId" bigint NOT NULL,
    "productId" bigint NOT NULL,
    "productName" text NOT NULL,
    "quantity" bigint NOT NULL,
    "unitPurchasePrice" double precision NOT NULL,
    "lineTotal" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "purchases" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "supplierName" text NOT NULL,
    "supplierPhone" text,
    "invoiceNumber" text NOT NULL,
    "totalAmount" double precision NOT NULL,
    "paidAmount" double precision NOT NULL,
    "dueAmount" double precision NOT NULL,
    "notes" text,
    "purchasedAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR go_dukaan
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('go_dukaan', '20261010085544782', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010085544782', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
