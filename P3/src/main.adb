with Ada.Text_IO; use Ada.Text_IO;
with mapaCharacters; use mapaCharacters;

procedure Main is
   map : mapa;
   state : Boolean;
begin
   state := put(map, "Hola Mundo qwerasdxfqwer qwervfqewrqcercqewr");

   declare
      claves : Keys (1 .. size(map));
   begin
      claves := getList (map);

   end;

end Main;
