with Ada.Text_IO; use Ada.Text_IO;
with mapaCharacters; use mapaCharacters;

procedure Main is
   map : mapa;
   state : Boolean;
begin
   state := put(map, "Hola Mundo qwerasdxfqwer qwervfqewrqcercqewr");

   declare
      claves : Keys (1 .. size(map));

      procedure Test (
   begin
      claves := getList (map);
      for I in claves'Range loop
         Put (claves (I) & ": ");
         Put (get(map, claves(I))'Img & "               ");
         if ((I mod 5) = 0) then
            Put_Line ("");
         end if;
      end loop;

   end;

   --claves := getList (map);
end Main;
