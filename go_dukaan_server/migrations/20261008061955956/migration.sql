BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "name" text NOT NULL,
    "sku" text,
    "barcode" text,
    "category" text NOT NULL,
    "purchasePrice" double precision NOT NULL,
    "sellingPrice" double precision NOT NULL,
    "stockQuantity" bigint NOT NULL,
    "lowStockAlert" bigint NOT NULL,
    "unit" text NOT NULL,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "product_shop_idx" ON "product" USING btree ("shopId");
CREATE INDEX "product_barcode_idx" ON "product" USING btree ("barcode");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "product"
    ADD CONSTRAINT "product_fk_0"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR go_dukaan
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('go_dukaan', '20261008061955956', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008061955956', "timestamp" = now();

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
