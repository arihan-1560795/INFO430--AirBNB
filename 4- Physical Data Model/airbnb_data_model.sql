-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-15 06:58:03.691

-- tables
-- Table: Amenity
CREATE TABLE Amenity (
    amenity_id int  NOT NULL,
    amenity_name varchar(300)  NOT NULL,
    CONSTRAINT Amenity_pk PRIMARY KEY (amenity_id)
);

-- Table: Calendar
CREATE TABLE Calendar (
    listing_id int  NOT NULL,
    Date date  NOT NULL,
    Available boolean  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT Calendar_pk PRIMARY KEY (listing_id)
);

CREATE INDEX FK on Calendar (listing_id ASC);

-- Table: Host
CREATE TABLE Host (
    host_id int  NOT NULL,
    host_name varchar(300)  NOT NULL,
    host_start_date date  NOT NULL,
    host_location varchar(300)  NOT NULL,
    host_description varchar(500)  NOT NULL,
    host_response_time time  NOT NULL,
    host_response_rate int  NOT NULL,
    host_identity_verified boolean  NOT NULL,
    CONSTRAINT Host_pk PRIMARY KEY (host_id)
);

-- Table: Listing
CREATE TABLE Listing (
    listing_id serial  NOT NULL,
    listing_url varchar(300)  NOT NULL,
    listing_name varchar(300)  NOT NULL,
    listing_summary varchar(300)  NOT NULL,
    host_id int  NOT NULL,
    listing_type varchar(300)  NOT NULL,
    weekly_price money  NOT NULL,
    monthly_price money  NOT NULL,
    deposits_total money  NOT NULL,
    cleaning_fee money  NOT NULL,
    extra_people_cost money  NOT NULL,
    minimum_nights int  NOT NULL,
    maximum_nights int  NOT NULL,
    availability_365 int  NOT NULL,
    location_id int  NOT NULL,
    street varchar(60)  NOT NULL,
    coordinates point  NOT NULL,
    square_feet int  NOT NULL,
    accommodates int  NOT NULL,
    bathrooms int  NOT NULL,
    bedrooms int  NOT NULL,
    property_type varchar(300)  NOT NULL,
    room_type varchar(60)  NOT NULL,
    total_reviews int  NOT NULL,
    bed_type varchar(60)  NOT NULL,
    cancellation_policy varchar(60)  NOT NULL,
    review_scores_rating int  NOT NULL,
    review_scores_cleanliness int  NOT NULL,
    review_scores_checkin int  NOT NULL,
    review_scores_location int  NOT NULL,
    review_scores_value int  NOT NULL,
    listing_details_id int  NOT NULL,
    CONSTRAINT Listing_pk PRIMARY KEY (listing_id)
);

CREATE INDEX listings on Listing (host_id ASC);

CREATE INDEX locations on Listing (location_id ASC);

-- Table: Listing_Details
CREATE TABLE Listing_Details (
    listing_details_id int  NOT NULL,
    space varchar(300)  NOT NULL,
    description varchar(300)  NOT NULL,
    experiences_offered varchar(300)  NOT NULL,
    notes varchar(300)  NOT NULL,
    transit varchar(300)  NOT NULL,
    photos_id int  NOT NULL,
    listing_rating float  NOT NULL,
    CONSTRAINT Listing_Details_pk PRIMARY KEY (listing_details_id)
);

-- Table: Neighbourhood
CREATE TABLE Neighbourhood (
    neighbourhood_id int  NOT NULL,
    neighbourhood_group varchar(300)  NOT NULL,
    neighborhood_details varchar(500)  NOT NULL,
    CONSTRAINT Neighbourhood_pk PRIMARY KEY (neighbourhood_id)
);

-- Table: Photos
CREATE TABLE Photos (
    photos_id int  NOT NULL,
    photo_type varchar(60)  NOT NULL,
    photo_url varchar(300)  NOT NULL,
    listing_details_id int  NOT NULL,
    CONSTRAINT Photos_pk PRIMARY KEY (photos_id)
);

-- Table: Review
CREATE TABLE Review (
    review_id int  NOT NULL,
    listing_id int  NOT NULL,
    date date  NOT NULL,
    review varchar(300)  NOT NULL,
    reviewer_id int  NOT NULL,
    CONSTRAINT Review_pk PRIMARY KEY (review_id)
);

-- Table: Reviewer
CREATE TABLE Reviewer (
    reviewer_id int  NOT NULL,
    firstname varchar(300)  NOT NULL,
    lastname varchar(300)  NOT NULL,
    CONSTRAINT Reviewer_pk PRIMARY KEY (reviewer_id)
);

-- Table: listing_amenity
CREATE TABLE listing_amenity (
    listing_amenity_id int  NOT NULL,
    listing_id int  NOT NULL,
    amenity_id int  NOT NULL,
    CONSTRAINT listing_amenity_pk PRIMARY KEY (listing_amenity_id)
);

-- Table: location
CREATE TABLE location (
    location_id int  NOT NULL,
    Zipcode int  NOT NULL,
    neighbourhood_id int  NOT NULL,
    CONSTRAINT location_pk PRIMARY KEY (location_id)
);

-- foreign keys
-- Reference: Calendar_Listing (table: Calendar)
ALTER TABLE Calendar ADD CONSTRAINT Calendar_Listing
    FOREIGN KEY (listing_id)
    REFERENCES Listing (listing_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Listing_Host (table: Listing)
ALTER TABLE Listing ADD CONSTRAINT Listing_Host
    FOREIGN KEY (host_id)
    REFERENCES Host (host_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Listing_Listing_Details (table: Listing)
ALTER TABLE Listing ADD CONSTRAINT Listing_Listing_Details
    FOREIGN KEY (listing_details_id)
    REFERENCES Listing_Details (listing_details_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Listing_Review (table: Review)
ALTER TABLE Review ADD CONSTRAINT Listing_Review
    FOREIGN KEY (listing_id)
    REFERENCES Listing (listing_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Photos_Listing_Details (table: Photos)
ALTER TABLE Photos ADD CONSTRAINT Photos_Listing_Details
    FOREIGN KEY (listing_details_id)
    REFERENCES Listing_Details (listing_details_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Review_Reviewer (table: Review)
ALTER TABLE Review ADD CONSTRAINT Review_Reviewer
    FOREIGN KEY (reviewer_id)
    REFERENCES Reviewer (reviewer_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: listing_amenity_Amenity (table: listing_amenity)
ALTER TABLE listing_amenity ADD CONSTRAINT listing_amenity_Amenity
    FOREIGN KEY (amenity_id)
    REFERENCES Amenity (amenity_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: listing_amenity_Listing (table: listing_amenity)
ALTER TABLE listing_amenity ADD CONSTRAINT listing_amenity_Listing
    FOREIGN KEY (listing_id)
    REFERENCES Listing (listing_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: location_Listing (table: Listing)
ALTER TABLE Listing ADD CONSTRAINT location_Listing
    FOREIGN KEY (location_id)
    REFERENCES location (location_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: location_Neighbourhood (table: location)
ALTER TABLE location ADD CONSTRAINT location_Neighbourhood
    FOREIGN KEY (neighbourhood_id)
    REFERENCES Neighbourhood (neighbourhood_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

