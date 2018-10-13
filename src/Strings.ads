package Strings with SPARK_Mode is
   subtype Character_Range is Character range ' ' .. '~';

   type Keys is array (Positive range 1 .. 200) of Character_Range;


   type Value is array (Positive range 1 .. 200) of Natural;
   subtype map_Range is Natural range 0 .. 200;

   type map is private;

   function size (mapa : map) return map_Range;
   function claves (mapa : map) return Keys;
   function valores (mapa : map) return Value;
   function is_Init (mapa : map) return Boolean;

   function areDiferent (mapa : map) return Boolean is
      (for all I in 1 .. size(mapa) =>
          (for all J in 1 .. size(mapa) =>
               (if I < J then claves(mapa)(I) /= claves(mapa)(J))));



   function search (mapa : map; char : Character_Range) return Integer
     with
       Pre => is_Init(mapa),
       Post =>
         (if search'Result = -1 then
             (for all I in 1 ..  size(mapa) =>
                  claves(mapa)(I) /= char)
         else
             claves(mapa)(search'Result) = char and
             search'Result in map_Range);

   procedure initMap(mapa : in out map);

   function contantsKey (mapa : map; char : Character_Range) return Boolean
     with
       Pre => is_Init(mapa),
     Post => (if contantsKey'Result then
                (for some I in 1 ..  size(mapa) => claves(mapa)(I) = char)
             else
                 (for all I in 1 ..  size(mapa) => claves(mapa)(I) /= char));

   function get (mapa : map; char : Character_Range) return Integer
     with
       Pre => is_Init(mapa),
       Post => (if get'Result = -1 then
                (for all I in 1 .. size(mapa) =>
                     claves(mapa)(I) /= char)
               else
                (for some I in 1 ..  size(mapa) => claves(mapa)(I) = char and valores(mapa)(I) = get'Result));

   procedure put (mapa : in out map ; char : Character_Range; value : Natural)
     with
       Global => null,
       Pre => is_Init(mapa),
     Post => (if size (mapa'Old) = size(mapa) then
                  -- TODO: Falta especificar cuando cambiar un valor interno de una variable
                  True
             else
                  (for all I in 1 ..  size(mapa'Old) => claves(mapa)(I) /= char) and
                    claves(mapa)(size(mapa)) = char and
                    valores(mapa)(size(mapa)) = value);
private

   type map is record
      init : Boolean;
      claves : Keys;
      valores : Value;
      length : map_Range;
   end record;

   function size (mapa : map) return map_Range is (mapa.length);
   function claves (mapa : map) return Keys is (mapa.claves);
   function valores (mapa : map) return Value is (mapa.valores);
   function is_Init (mapa : map) return Boolean is (mapa.init);
 end Strings;

