-- Add multilingual support for allergens
-- This migration adds Danish and English columns to the Allergens table
-- and migrates existing data to support both languages

-- Add new columns for multilingual allergen names
ALTER TABLE "public"."Allergens" 
ADD COLUMN "allergen_name_da" text,
ADD COLUMN "allergen_name_en" text;

-- Migrate existing data: assume current allergen_name is in Danish
-- and create English equivalents for common allergens
UPDATE "public"."Allergens" 
SET "allergen_name_da" = "allergen_name",
    "allergen_name_en" = CASE 
        WHEN LOWER("allergen_name") LIKE '%gluten%' THEN 'Gluten'
        WHEN LOWER("allergen_name") LIKE '%mælk%' OR LOWER("allergen_name") LIKE '%dairy%' THEN 'Dairy'
        WHEN LOWER("allergen_name") LIKE '%æg%' OR LOWER("allergen_name") LIKE '%egg%' THEN 'Eggs'
        WHEN LOWER("allergen_name") LIKE '%nød%' OR LOWER("allergen_name") LIKE '%nut%' THEN 'Nuts'
        WHEN LOWER("allergen_name") LIKE '%soja%' OR LOWER("allergen_name") LIKE '%soy%' THEN 'Soy'
        WHEN LOWER("allergen_name") LIKE '%fisk%' OR LOWER("allergen_name") LIKE '%fish%' THEN 'Fish'
        WHEN LOWER("allergen_name") LIKE '%skaldyr%' OR LOWER("allergen_name") LIKE '%shellfish%' THEN 'Shellfish'
        WHEN LOWER("allergen_name") LIKE '%sesam%' OR LOWER("allergen_name") LIKE '%sesame%' THEN 'Sesame'
        WHEN LOWER("allergen_name") LIKE '%selleri%' OR LOWER("allergen_name") LIKE '%celery%' THEN 'Celery'
        WHEN LOWER("allergen_name") LIKE '%sennep%' OR LOWER("allergen_name") LIKE '%mustard%' THEN 'Mustard'
        WHEN LOWER("allergen_name") LIKE '%svovl%' OR LOWER("allergen_name") LIKE '%sulfite%' THEN 'Sulfites'
        WHEN LOWER("allergen_name") LIKE '%lupin%' THEN 'Lupin'
        WHEN LOWER("allergen_name") LIKE '%blød%' OR LOWER("allergen_name") LIKE '%mollusk%' THEN 'Mollusks'
        WHEN LOWER("allergen_name") LIKE '%peanut%' OR LOWER("allergen_name") LIKE '%jordnød%' THEN 'Peanuts'
        -- Default case: use the original name as fallback
        ELSE "allergen_name"
    END;

-- Make the new columns not null after migration
ALTER TABLE "public"."Allergens" 
ALTER COLUMN "allergen_name_da" SET NOT NULL,
ALTER COLUMN "allergen_name_en" SET NOT NULL;

-- Make original allergen_name nullable for backwards compatibility
ALTER TABLE "public"."Allergens" 
ALTER COLUMN "allergen_name" DROP NOT NULL;

-- Add comment to document the migration
COMMENT ON TABLE "public"."Allergens" IS 'Allergens table with multilingual support. allergen_name_da contains Danish names, allergen_name_en contains English names. Original allergen_name column maintained for backwards compatibility.';
COMMENT ON COLUMN "public"."Allergens"."allergen_name_da" IS 'Allergen name in Danish';
COMMENT ON COLUMN "public"."Allergens"."allergen_name_en" IS 'Allergen name in English';
COMMENT ON COLUMN "public"."Allergens"."allergen_name" IS 'Original allergen name column (deprecated, kept for backwards compatibility)';