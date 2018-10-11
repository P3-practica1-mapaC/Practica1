--Mapa de caracteres.

package mapaCharacters with SPARK_Mode is

   type mapa is private;
   type Keys is array (Positive range <>) of Character;

   function claves (map : mapa) return Keys ;
   function size (map : mapa) return Integer;

   procedure put (map : in out mapa; Key : String)
     with
       Pre => True,
       Post => True;


   No_Control : constant Character := ASCII.US;

   function containsKey (map : mapa; Key : Character) return Boolean
     with
       Pre => size(map) > 0 and size (map) < claves(map)'Last and Key > No_Control,
       Post => (if containsKey'Result then
                  (for some I in 1 .. size(map) =>
                         claves(map)(I) = Key)
                else
                  (for all I in 1 .. size(map) =>
                        claves(map)(I) /= Key));

   function get (map : mapa; Key : Character) return Integer;


   function getList (map : mapa) return Keys
     with
       Pre => size (map) > 0 and then size(map) < 101,
       Post => getList'Result'Length = size (map) and then
               (for all I in getList'Result'Range =>
                 getList'Result(I) = claves(map)(I));


private

   type Values is array (Positive range <>) of Integer;

   type mapa is record
      keyList : Keys (1 .. 200);
      valueList : Values (1 .. 200);
      Length : Integer := 0;
   end record;

   function size (map : mapa) return Integer is (Map.Length);
   function claves (map : mapa) return Keys is (map.keyList);

   function search (map : mapa; value : Character) return Integer
     with
       Pre => size (map) < 201 and size(map) > 0,
       Post => (if search'Result > 0 and search'Result <= size(map) then
                      claves(map)(search'Result) = value
                else
                      search'Result = 0);


end mapaCharacters;
