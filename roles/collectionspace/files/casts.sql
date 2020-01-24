ALTER TYPE text OWNER TO csadmin;

CREATE FUNCTION public.text(integer) RETURNS text STRICT IMMUTABLE LANGUAGE SQL AS 'SELECT textin(int4out($1));';
CREATE CAST (integer AS text) WITH FUNCTION public.text(integer) AS IMPLICIT;
COMMENT ON FUNCTION public.text(integer) IS 'convert integer to text';

CREATE FUNCTION public.text(bigint) RETURNS text STRICT IMMUTABLE LANGUAGE SQL AS 'SELECT textin(int8out($1));';
CREATE CAST (bigint AS text) WITH FUNCTION public.text(bigint) AS IMPLICIT;
COMMENT ON FUNCTION public.text(bigint) IS 'convert bigint to text';
