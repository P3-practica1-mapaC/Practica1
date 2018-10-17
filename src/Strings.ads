package Strings with SPARK_Mode is
   subtype Character_Range is Character range ' ' .. '~';

   type Keys is array (Positive range <>) of Character_Range;


   type Value is array (Positive range <>) of Natural;

   subtype map_Range is Natural range 0 .. 500;
   subtype valid_map_Range is map_Range range 1 .. 500;
   type map is private;

   function size (mapa : map) return map_Range;
   function claves (mapa : map) return Keys;
   function valores (mapa : map) return Value;
   function is_Init (mapa : map) return Boolean;

   function areDiferent (mapa : map) return Boolean is
      (for all I in 1 .. size(mapa) =>
          (for all J in 1 .. size(mapa) =>
               (if I < J then claves(mapa)(I) /= claves(mapa)(J))));

   function stayTheSame (mapa : map; mapaOld : map; exclude : Boolean; index : valid_map_Range) return Boolean is
      (for all I in 1 ..  size(mapaOld) =>
          (if exclude  and then claves(mapa)(index) /= claves(mapa)(I) then
                claves(mapaOld)(I) = claves(mapa)(I) and
                valores(mapaOld)(I) = valores(mapa)(I)));

   Not_Found : constant Natural := 0;

   function search (mapa : map; char : Character_Range) return map_Range
     with
       Global => null,
       Depends => (search'Result => (mapa, char)),
       Pre => is_Init(mapa),
       Post =>
         (if search'Result in 1 .. size(mapa) then
             claves(mapa)(search'Result) = char
         else
             search'Result = Not_Found and
             (for all I in 1 ..  size(mapa) => claves(mapa)(I) /= char));

   procedure initMap(mapa : in out map);

   function containsKey (mapa : map; char : Character_Range) return Boolean
     with
       Global => null,
       Depends => (containsKey'Result => (mapa, char)),
       Pre => is_Init(mapa),
       Post => (if containsKey'Result then
                  (for some I in 1 ..  size(mapa) => claves(mapa)(I) = char)
               else
                  (for all I in 1 ..  size(mapa) => claves(mapa)(I) /= char));

   function get (mapa : map; char : Character_Range) return Integer
     with
       Global => null,
       Depends => (get'Result => (mapa, char)),
       Pre => is_Init(mapa),
       Post =>
          (if get'Result in Natural then
              (for some I in 1 ..  size(mapa) => claves(mapa)(I) = char and valores(mapa)(I) = get'Result)
           else
              get'Result = -1);

   procedure put (mapa : in out map ; char : Character_Range; value : Natural)
     with
       Global => null,
       Pre => is_Init(mapa)  and areDiferent(mapa),
       Post =>  areDiferent(mapa) and then
         ((if size (mapa'Old) = size(mapa) then
             (if search(mapa, char) in 1 .. size(mapa) then
                  claves(mapa)(search(mapa, char)) = char and
                  valores(mapa)(search(mapa, char)) = value and
                  stayTheSame(mapa, mapa'Old, True, search(mapa, char))
             else
                  stayTheSame(mapa, mapa'Old, False, 1))
         else
             stayTheSame(mapa, mapa'Old, False, 1) and
             size(mapa) = size(mapa'Old) + 1 and
             claves(mapa)(size(mapa)) = char and
             valores(mapa)(size(mapa)) = value));

   function getList (mapa : map) return Keys with
     Global => null,
     Depends => (getList'Result => mapa),
     Pre  =>  is_Init(mapa),
     Post => (for all I in 1 .. size(mapa) =>
                  getList'Result(I) = claves(mapa)(I));

private

   type map is record
      init : Boolean;
      claves : Keys(1 .. 500);
      valores : Value(1 .. 500);
      length : map_Range;
   end record;

   function size (mapa : map) return map_Range is (mapa.length);
   function claves (mapa : map) return Keys is (mapa.claves);
   function valores (mapa : map) return Value is (mapa.valores);
   function is_Init (mapa : map) return Boolean is (mapa.init);
 end Strings;

