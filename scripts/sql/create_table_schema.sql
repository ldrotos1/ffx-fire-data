-- Create the table schema --
CREATE SCHEMA ffx_fire_ops
	AUTHORIZATION postgres;

-- Enable post GIS --
CREATE EXTENSION postgis;

-- Create the fire department table --
CREATE TABLE ffx_fire_ops.department
(
    dept_id integer,
    dept_full_name text NOT NULL,
    dept_short_name text NOT NULL,
    dept_abbreviation character varying(6) NOT NULL,
    dept_border geometry(Polygon,4326),
    PRIMARY KEY (dept_id)
);

-- Create the station table --
CREATE TABLE ffx_fire_ops.station
(
    station_designator integer,
    station_number integer NOT NULL,
    station_name text NOT NULL,
    battalion integer NOT NULL,
    divison integer,
    is_battalion_hq boolean NOT NULL DEFAULT False,
    is_division_hq boolean NOT NULL DEFAULT False,
    is_volunteer boolean NOT NULL DEFAULT False,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    zip integer NOT NULL,
	department_id integer,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    location geometry(Point,4326) DEFAULT NULL,
    PRIMARY KEY (station_designator),
    CONSTRAINT dept_fk FOREIGN KEY (department_id)
        REFERENCES ffx_fire_ops.department (dept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL
);

-- Create the station first due area table --
CREATE TABLE ffx_fire_ops.first_due_area
(
    station_designator integer,
    first_due_area geometry(Polygon,4326) NOT NULL,
    PRIMARY KEY (station_designator),
    CONSTRAINT station_fk FOREIGN KEY (station_designator)
        REFERENCES ffx_fire_ops.station (station_designator) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Create the apparatus type table --
CREATE TABLE ffx_fire_ops.apparatus_type
(
    apparatus_type_id integer,
    apparatus_type character varying(35) NOT NULL,
    apparatus_category character varying(30) NOT NULL,
    apparatus_image character varying(30) NOT NULL,
    max_staff integer NOT NULL,
    min_staff_ff integer NOT NULL,
    min_staff_tech integer NOT NULL,
    min_staff_officer integer NOT NULL,
    min_staff_command integer NOT NULL,
    is_paramedic_required boolean NOT NULL,
    is_cross_staffed boolean NOT NULL,
    is_vol_staffed boolean NOT NULL,
    PRIMARY KEY (apparatus_type_id)
);

-- Create the apparatus table --
CREATE TABLE ffx_fire_ops.apparatus
(
    unit_designator character varying(12) NOT NULL,
    apparatus_type_id integer NOT NULL,
    station_designator integer NOT NULL,
    dept_id integer NOT NULL,
    is_reserved boolean NOT NULL DEFAULT False,
    year integer,
    make character varying(40),
    model character varying(40),
    PRIMARY KEY (unit_designator),
    CONSTRAINT dept_id_fk FOREIGN KEY (dept_id)
        REFERENCES ffx_fire_ops.department (dept_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT station_desig_fk FOREIGN KEY (station_designator)
        REFERENCES ffx_fire_ops.station (station_designator) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL,
    CONSTRAINT apparatus_type_id_fk FOREIGN KEY (apparatus_type_id)
        REFERENCES ffx_fire_ops.apparatus_type (apparatus_type_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

-- Create the user account table --
CREATE TABLE ffx_fire_ops.user_account
(
    username character varying(50),
    email character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    is_account_locked boolean NOT NULL DEFAULT FALSE,
    created_on timestamp NOT NULL DEFAULT NOW(),
    created_by character varying(50) NOT NULL,
    updated_on timestamp NOT NULL DEFAULT NOW(),
    updated_by character varying(50) NOT NULL,
    expires_on timestamp NOT NULL DEFAULT (NOW() + interval '1 year'),
    PRIMARY KEY (username)
);

-- Create the user role table --
CREATE TABLE ffx_fire_ops.account_role
(
    role_name character varying(25) NOT NULL,
    role_description text NOT NULL,
    PRIMARY KEY (role_name)
);

-- Create the user_account_role table --
CREATE TABLE ffx_fire_ops.user_account_role
(
    username character varying(50) REFERENCES ffx_fire_ops.user_account(username) ON DELETE CASCADE,
    role_name character varying(25) REFERENCES ffx_fire_ops.account_role(role_name) ON DELETE CASCADE,
    PRIMARY KEY(username,role_name)
);