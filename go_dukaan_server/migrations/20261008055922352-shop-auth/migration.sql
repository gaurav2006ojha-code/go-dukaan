BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "shop" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shop" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "shopName" text NOT NULL,
    "ownerName" text NOT NULL,
    "businessType" text NOT NULL,
    "mobile" text NOT NULL,
    "city" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "auth_user_id_unique_idx" ON "shop" USING btree ("authUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "shop"
    ADD CONSTRAINT "shop_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR go_dukaan
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('go_dukaan', '20261008055922352-shop-auth', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008055922352-shop-auth', "timestamp" = now();

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
