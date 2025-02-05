SELECT jsonb_build_object(
    'type',     'FeatureCollection',
    'features', jsonb_agg(features.feature)
) FROM (
  SELECT jsonb_build_object(
    'type',       'Feature',
    'gid',         $[id],
    'geometry',   ST_AsGeoJSON($[geom:raw])::jsonb,
    'properties', to_jsonb(inputs) - $[geom]
  ) AS feature
  FROM (SELECT * FROM $[table:raw]) inputs) features;