BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "customer" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "name" text NOT NULL,
    "mobile" text,
    "email" text,
    "address" text,
    "totalDue" double precision NOT NULL,
    "totalPaid" double precision NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "customer_shop_idx" ON "customer" USING btree ("shopId");
CREATE INDEX "customer_mobile_idx" ON "customer" USING btree ("mobile");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "customer"
    ADD CONSTRAINT "customer_fk_0"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR go_dukaan
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('go_dukaan', '20261008134758935-customer', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008134758935-customer', "timestamp" = now();

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
