BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sale" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "customerId" bigint,
    "invoiceNumber" text NOT NULL,
    "subtotal" double precision NOT NULL,
    "discountAmount" double precision NOT NULL,
    "taxAmount" double precision NOT NULL,
    "totalAmount" double precision NOT NULL,
    "paidAmount" double precision NOT NULL,
    "dueAmount" double precision NOT NULL,
    "paymentMethod" text NOT NULL,
    "status" text NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "sale_shop_idx" ON "sale" USING btree ("shopId");
CREATE INDEX "sale_customer_idx" ON "sale" USING btree ("customerId");
CREATE UNIQUE INDEX "sale_invoice_unique_idx" ON "sale" USING btree ("shopId", "invoiceNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sale_item" (
    "id" bigserial PRIMARY KEY,
    "saleId" bigint NOT NULL,
    "productId" bigint NOT NULL,
    "productName" text NOT NULL,
    "quantity" bigint NOT NULL,
    "unitPrice" double precision NOT NULL,
    "purchasePrice" double precision NOT NULL,
    "discountAmount" double precision NOT NULL,
    "lineTotal" double precision NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "sale_item_sale_idx" ON "sale_item" USING btree ("saleId");
CREATE INDEX "sale_item_product_idx" ON "sale_item" USING btree ("productId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sale"
    ADD CONSTRAINT "sale_fk_0"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sale"
    ADD CONSTRAINT "sale_fk_1"
    FOREIGN KEY("customerId")
    REFERENCES "customer"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sale_item"
    ADD CONSTRAINT "sale_item_fk_0"
    FOREIGN KEY("saleId")
    REFERENCES "sale"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "sale_item"
    ADD CONSTRAINT "sale_item_fk_1"
    FOREIGN KEY("productId")
    REFERENCES "product"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR go_dukaan
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('go_dukaan', '20261009075755878-billing', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261009075755878-billing', "timestamp" = now();

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
