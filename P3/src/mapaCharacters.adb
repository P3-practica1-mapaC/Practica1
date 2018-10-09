with Ada.Text_IO; use Ada.Text_IO;

package body mapaCharacters is

   function search (map : mapa; value : String) return Integer is
   begin
      if map.Length = 0 then
         return -1;
      end if;
      for I in map.keyList'First .. map.Length loop
         if map.keyList(I) = value then
            return I;
         end if;
      end loop;
      return -1;
   end search;


   function put (map : in out mapa; Key : String) return Boolean is
      value, index : Integer;
   begin
      for I in Key'First .. Key'Last loop
         if map.Length = map.keyList'Last then
            exit;
         end if;
         index := search (map, Key(I .. I));
         if index > -1 then
            value := map.valueList(index) + 1;
         else
            map.Length := map.Length + 1;
            index := map.Length;
            map.keyList (index) := key(I .. I);
            value := 1;
         end if;
         map.valueList(index) := value;
      end loop;

      return True;
   end put;

   function constainsKey (map : in out mapa; Key : String) return Boolean is
   begin
      return True;
   end constainsKey;

   function get (map : in out mapa; Key : String) return Integer is
      index : Integer := search(map, Key);
   begin
      return map.valueList(index);
   end get;

   function getList (map : in out mapa) return Keys is
      result : Keys (1 .. map.Length);
   begin
      for I in 1 .. map.Length loop
         result (I) := map.keyList(I);
      end loop;
      return result;
   end getList;

   function size (map : mapa) return Integer is
   begin
      return map.Length;
   end size;

end mapaCharacters;
