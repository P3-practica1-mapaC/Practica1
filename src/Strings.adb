with Ada.Text_IO; use Ada.Text_IO;

package body Strings  with SPARK_Mode is


   function search (mapa : map; char : Character_Range) return Integer is
      I : Positive := 1;
   begin
      while I <= mapa.length loop
         if mapa.claves(I) = char then
            return I;
         end if;
         I := I + 1;
         pragma Loop_Variant (Decreases => (mapa.length - I));
         pragma Loop_Invariant ((I - 1) in map_Range);
         pragma Loop_Invariant (for all K in 1 .. (I-1) =>
                                  mapa.claves(K) /= char);
      end loop;
      return -1;
   end search;



   procedure initMap(mapa : in out map) is
   begin
      mapa.init := True;
      mapa.length := 0;
   end initMap;

   function contantsKey (mapa : map; char : Character_Range) return Boolean is
   begin
      for I in 1 .. mapa.length loop
         if mapa.claves(I) = char then
            return True;
         end if;
         pragma Loop_Invariant (for all K in 1 .. I =>
                               mapa.claves(K) /= char);
      end loop;
      return False;
   end contantsKey;


   function get (mapa : map; char : Character_Range) return Integer is
   begin
      for I in 1 .. mapa.length loop
         if mapa.claves(I) =  char then
            return mapa.valores(I);
         end if;
         pragma Loop_Invariant (for all K in 1 .. I =>
                               mapa.claves(K) /= char);
      end loop;
      return -1;
   end get;


   procedure put (mapa : in out map ; char : Character_Range; value : Natural) is
      index : Positive := 1;
      hecho : Boolean := False;
   begin
      while index <=  mapa.length loop
         if mapa.claves(index) = char then
            mapa.valores(index) := value;
            hecho := True;
            exit;
         end if;
         pragma Loop_Variant (Increases => index);
         pragma Loop_Invariant (index in map_Range);
         pragma Loop_Invariant (for all K in 1 .. index =>
                                  mapa.claves(K) /= char);
         index := index + 1;
      end loop;

      if not hecho and mapa.length < mapa.claves'Length then
         mapa.length := mapa.length + 1;
         mapa.claves(mapa.length) := char;
         mapa.valores(mapa.length) := value;
      end if;
   end put;


end Strings;
