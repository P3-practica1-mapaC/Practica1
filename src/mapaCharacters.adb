with Ada.Text_IO; use Ada.Text_IO;

package body mapaCharacters with SPARK_Mode is


   function search (map : mapa; value : Character) return Integer is
      I : Positive := 1;
   begin
      if map.Length <= 0 then
         return 0;
      end if;
      while I <= map.Length loop
         if map.keyList(I) = value then
            return I;
         end if;
         I := I + 1;
         pragma Loop_Variant (decreases => (map.Length - I));
      end loop;
      return 0;
   end search;

   procedure put (map : in out mapa; Key : String) is
      value, index : Integer;
      char : Character;
   begin
      for I in Key'First .. Key'Last loop
         if map.Length = map.keyList'Last then
            exit;
         end if;
         char := Character (Key(I));
         index := search (map, char);
         if index > 0 then
            value := map.valueList(index) + 1;
         else
            map.Length := map.Length + 1;
            index := map.Length;
            map.keyList (index) := char;
            value := 1;
         end if;
         map.valueList(index) := value;
      end loop;
   end put;

   function containsKey (map : mapa; Key : Character) return Boolean is
   begin
      return search (map, Key) > 0;
   end containsKey;

   function get (map :  mapa; Key : Character) return Integer is
      index : Integer := search(map, Key);
   begin
      if (index > 0) then
         return map.valueList(index);
      end if;
      return -1;
   end get;

   function getList (map :  mapa) return Keys is
      result : Keys (1 .. map.Length) := (others => ' ');
   begin
      for I in 1 .. map.Length loop
         result (I) := map.keyList(I);
         pragma Loop_Invariant (for all K in 1 .. I  =>
                               result (K) = map.keyList(K));
      end loop;
      return result;
   end getList;

end mapaCharacters;
