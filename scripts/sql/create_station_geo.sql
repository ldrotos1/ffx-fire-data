UPDATE ffx_fire_ops.station
SET location = ST_SetSRID(ST_MakePoint(lon,lat),4326);
CREATE INDEX location_index ON ffx_fire_ops.station USING GIST (location);