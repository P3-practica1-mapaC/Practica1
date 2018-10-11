--Mapa de caracteres.

package mapaCharacters is

   type mapa is private;
   type Keys is array (Positive range <>) of Character;

   function put (map : in out mapa; Key : String) return Boolean;

   function constainsKey (map : in out mapa; Key : Character) return Boolean;

   function get (map : in out mapa; Key : Character) return Integer;

   function getList (map : in out mapa) return Keys;

   function size (map : mapa) return Integer ;

private

   type Values is array (Positive range <>) of Integer;

   type mapa is record
      keyList : Keys (1 .. 100);
      valueList : Values (1 .. 100);
      Length : Integer := 0;
   end record;

   function search (map : mapa; value : Character) return Integer;

end mapaCharacters;
