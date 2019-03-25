-- Returns all listings within the radius as specified by user
create or replace function listingsWithinRadius(id int, radius float)
  RETURNS table(
    listingid int,
    dist numeric
  ) AS $$
  DECLARE
    lat float;
    lon float;
  BEGIN
    lat := (select listing_locations.latitude from listing_locations where listing_locations.listingid = id);
    lon := (select listing_locations.longitude from listing_locations where listing_locations.listingid = id);

    RETURN query select listing_locations.listingid, round((point(lon, lat) <@> point(listing_locations.longitude, listing_locations.latitude))::numeric,3) as dist from listing_locations
    WHERE (point(lon, lat) <@> point(listing_locations.longitude, listing_locations.latitude)) < radius AND  listing_locations.listingid != id;
  end;
$$LANGUAGE plpgsql;


-- Checks if zipcode is a valid Seattle zipcode
CREATE OR REPLACE FUNCTION zip_code_check()
  RETURNS trigger AS 
$BODY$
BEGIN
 IF NEW.Zipcode < 98101 OR New.Zipcode > 98199
 THEN
 	RAISE EXCEPTION '% is an invalid Seattle Zip Code.', NEW.Zipcode;
 END IF;
 RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER zip_check
  BEFORE INSERT
  ON location
  FOR EACH ROW
  EXECUTE PROCEDURE zip_code_check();

INSERT INTO location(location_id, zipcode, neighbourhood_id) VALUES (1, 98000, 1); -- invalid zipcode test
INSERT INTO location(location_id, zipcode, neighbourhood_id) VALUES (1, 98101, 1); -- valid zipcode test


-- Checks if price inserted is valid (not negative value)
CREATE OR REPLACE FUNCTION price_checker()
  RETURNS trigger AS 
$BODY$
BEGIN
 IF NEW.Price < 0::money
 THEN
 	RAISE EXCEPTION '% is an invalid price. Price must be positive.', NEW.Price;
 END IF;
 RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER price_check
  BEFORE INSERT
  ON Calendar
  FOR EACH ROW
  EXECUTE PROCEDURE price_checker();

INSERT INTO calendar(date, available, price) VALUES ('2018-10-12', TRUE, '-10'); -- invalid price test
INSERT INTO calendar(date, available, price) VALUES ('2018-10-12', TRUE, '10'); -- valid price test


-- Checks that listing contains at least 1 bathroom and 1 bedroom
CREATE OR REPLACE FUNCTION room_checker()
  RETURNS trigger AS 
$BODY$
BEGIN
 IF NEW.bathrooms < 1 OR NEW.bedrooms < 1
 THEN
 	RAISE EXCEPTION '% bathroom and % bedroom is invalid. Must have at least 1 bedroom and bathroom', NEW.bathrooms, NEW.bedrooms;
 END IF;
 RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER room_check
  BEFORE INSERT
  ON listing
  FOR EACH ROW
  EXECUTE PROCEDURE room_checker();

-- Invalid insert into listing with less than 1 bedroom and bathroom
INSERT INTO Listing (listing_id,
                     listing_url,
                     listing_name,
                     listing_summary,
                     host_id,
                     listing_type,
                     weekly_price,
                     monthly_price,
                     deposits_total,
                     cleaning_fee,
                     extra_people_cost,
                     minimum_nights,
                     maximum_nights,
                     availability_365,
                     location_id,
                     street,
                     coordinates,
                     square_feet,
                     accommodates,
                     bathrooms,
                     bedrooms,
                     property_type,
                     room_type,
                     total_reviews,
                     bed_type,
                     cancellation_policy ,
                     review_scores_rating,
                     review_scores_cleanliness,
                     review_scores_checkin,
                     review_scores_location,
                     review_scores_value,
                     listing_details_id)
VALUES (1,'blah','blah','blah', 1, 'blah', 20, 20, 20, 20, 20, 1, 1, 1, 1, 'University Way', POINT (30, 50), 20, 3, 0, 0, 'blah',
       'blah', 1, 'blah', 'blah', 1, 1, 1, 1, 1, 1);


-- Valid insert into listing with at least 1 bathroom and 1 bedroom
INSERT INTO Listing (listing_id,
                     listing_url,
                     listing_name,
                     listing_summary,
                     host_id,
                     listing_type,
                     weekly_price,
                     monthly_price,
                     deposits_total,
                     cleaning_fee,
                     extra_people_cost,
                     minimum_nights,
                     maximum_nights,
                     availability_365,
                     location_id,
                     street,
                     coordinates,
                     square_feet,
                     accommodates,
                     bathrooms,
                     bedrooms,
                     property_type,
                     room_type,
                     total_reviews,
                     bed_type,
                     cancellation_policy ,
                     review_scores_rating,
                     review_scores_cleanliness,
                     review_scores_checkin,
                     review_scores_location,
                     review_scores_value,
                     listing_details_id)
VALUES (2,'blah','blah','blah', 2, 'blah', 20, 20, 20, 20, 20, 2, 2, 2, 2, 'University Way',POINT (30, 50), 20, 4, 1, 1, 'blah',
       'blah', 2, 'blah', 'blah', 2, 2, 2, 2, 2, 2);

