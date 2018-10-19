with Ada.Text_IO; use Ada.Text_IO;

package body MapaCharacters  with SPARK_Mode is


   function search (mapa : map; char : Character_Range) return map_Range is
      I : Positive := 1;
   begin
      while I <= mapa.length loop
         if mapa.claves(I) = char then
            return I;
         end if;

         pragma Loop_Variant (Decreases => (mapa.length - I));
         pragma Loop_Invariant (I in 1 .. size(mapa));
         pragma Loop_Invariant (for all K in 1 .. I =>
                                  mapa.claves(K) /= char);
         I := I + 1;
      end loop;
      return 0;
   end search;



   procedure initMap(mapa : in out map) is
   begin
      mapa.init := True;
      mapa.length := 0;
   end initMap;

   function containsKey (mapa : map; char : Character_Range) return Boolean is
      index : map_Range := search(mapa, char);
   begin
      return index  in 1 .. mapa.length;
   end containsKey;


   function get (mapa : map; char : Character_Range) return Integer is
      index : map_Range := search(mapa, char);
   begin
      if index  in 1 .. mapa.length then
         return mapa.valores(index);
      end if;

      return -1;
   end get;


   procedure put (mapa : in out map ; char : Character_Range; value : Natural) is
      index : map_Range := search (mapa, char);
   begin

      if index in 1 .. mapa.length then
         mapa.valores(index) := value;
      elsif mapa.length < mapa.claves'Length then
         mapa.length := mapa.length + 1;
         mapa.claves(mapa.length) := char;
         mapa.valores(mapa.length) := value;
      end if;
   end put;

   function getList (mapa : map) return Keys is
      claves : Keys(1 .. mapa.length) := (others => ' ');
   begin
      for I in 1 ..  mapa.length loop
         claves(I) :=  mapa.claves(I);
         pragma Loop_Invariant (for all J in 1 .. I =>
                                   claves(J) = mapa.claves(J));
      end loop;
      return claves;
   end getList;

   function getChar (mapa : map; index : Integer) return Character is
   begin
      if not (index in 1 .. size(mapa)) then
         return ASCII.NUL;
      end if;
      return mapa.claves(index);

   end getChar;



end MapaCharacters;
