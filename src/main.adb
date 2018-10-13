with Strings; use Strings;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   mapa : map;
   cadena : String := "Holaaa";
begin
   initMap(mapa);



   for I in cadena'Range loop
      put(mapa, Character(cadena(I)), 1);
   end loop;


end Main;
