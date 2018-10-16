with Strings; use Strings;
with Ada.Text_IO; use Ada.Text_IO;
with Test_Assertions; use Test_Assertions;

procedure Main is
   mapa : map;
   cadena : String := "Holaaa";
   length : map_Range;

   procedure TestVacio is
      mapVac : map;
      x : Character;
   begin
      initMap(mapVac);
      -- size --
      Assert_True (size(mapVac) = 0, "Prueba en mapa vacio de size");
      Assert_False (size(mapVac) = 1, "Prueba en mapa vacio de size");
      -- put --

      -- search --
      Assert_True (search(mapVac, 'x') = 0, "Prueba en mapa vacio de search");
      Assert_True (search(mapVac, ' ') = 0, "Prueba en mapa vacio de search");

      -- containsKey --
      Assert_True (containsKey(mapVac, 'x') = false, "Prueba en mapa vacio de containsKey");

      begin
         Assert_True (containsKey(mapVac, x) = false, "Prueba error al buscar caracter no inicializado");
      exception
         when Constraint_Error => Put_Line ("Prueba error al buscar caracter no inicializado: OK!! ;  Constraint alzada");
         when others =>  Put_Line ("Prueba error al buscar caracter no inicializado: Failed!! ; Constrain no alzada");
      end;

      begin
         put(mapVac, x, 1);
      exception
         when Constraint_Error => Put_Line ("Prueba error intentar insertar variable caracter no inicializado: OK!! ;  Constraint alzada");
         when others =>  Put_Line ("Prueba error intentar insertar variable caracter no inicializado: Failed!! ; Constrain no alzada");
      end;

      Assert_True (containsKey(mapVac,' ') = false, "Prueba en mapa vacio de containsKey");
      -- get --
      Assert_True (get(mapVac, 'x') = -1, "Prueba en mapa vacio de get");
      Assert_True (get(mapVac, ' ') = -1, "Prueba en mapa vacio de get");

      -- getList --

      Assert_True ((getList(mapVac)'Last - getList(mapVac)'First) = -1, "Prueba en mapa vacio de getList");
      --Assert_True (getList(mapVac)., "Prueba en mapa vacio de get");

     exception
      when Test_Assertion_Error => Put_Line ("Failed(Asertation)");
      when others => Put_Line ("Failed (exception)");
   end TestVacio;


   procedure Test1 is
      mapVac : map;
      --x : Character;
   begin
      initMap(mapVac);

      put(mapVac,'x',1);
      -- size --
      Assert_True (size(mapVac) = 1, "Prueba en mapa vacio de size");

      -- search --
      Assert_True (search(mapVac, 'x') = 1, "Prueba en mapa vacio de search");
      Assert_True (search(mapVac, ' ') = 0, "Prueba en mapa vacio de search");
      Assert_True (search(mapVac, 'X') = 0, "Prueba en mapa vacio de search");


      -- containsKey --
      Assert_True (containsKey(mapVac, 'x') , "Prueba en mapa vacio de containsKey");
      Assert_True (containsKey(mapVac, 'a') = false, "Prueba en mapa vacio de containsKey");
      Assert_True (containsKey(mapVac,' ') = false, "Prueba en mapa vacio de containsKey");
      -- get --
      Assert_True (get(mapVac, 'x') = 1, "Prueba en mapa vacio de get");
      Assert_True (get(mapVac, ' ') = -1, "Prueba en mapa vacio de get");

      -- getList --

      --Assert_True (getList(mapVac) = ('x'), "Prueba en mapa vacio de getList");

      --Assert_True (getList(mapVac)., "Prueba en mapa vacio de get");
   exception
      when others =>
         null;

   end Test1;

begin
   initMap(mapa);

   Put_Line("Pruebas de mapas vacios");
   TestVacio;
   --Put_Line("Pruebas de mapa con un elemento");
   --Test1;

   for I in cadena'Range loop
      put(mapa, Character(cadena(I)), 1);
   end loop;

   length := size(mapa);
end Main;
