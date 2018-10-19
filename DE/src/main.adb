with MapaCharacters; use MapaCharacters;
with Ada.Text_IO; use Ada.Text_IO;
with Test_Assertions; use Test_Assertions;
with SYSTEM.ASSERTIONS;

procedure Main is


   procedure Test_MapaVacio is
      mapVac : map;
   begin

      initMap(mapVac);

      -- size --

      Assert_True (size(mapVac) = 0, "Prueba en mapa vacio de size");

      -- search --
      Put_Line("Prueba en mapa vacio de search, si hay error aparecera mensaje: ");
      for I in 32..124 loop
         Assert_False (search(mapVac, Character'Val(I)) > 0);
      end loop;

      -- containsKey --
      Put_Line("Prueba en mapa vacio de containsKey, si hay error aparecera mensaje: ");
      for I in 32..124 loop
         Assert_False (containsKey(mapVac, Character'Val(I)));

      end loop;
      -- get --
      Put_Line("Prueba en mapa vacio de get, si hay error aparecera mensaje: ");
      for I in 32..124 loop
         Assert_False (get(mapVac, Character'Val(I)) >= 0 );

      end loop;
      -- getList --
      Assert_true(getList(mapVac)'length = 0, "Prueba en mapa vacio de getList");

      Put_Line("Prueba en mapa vacio de getChar, si hay error aparecera mensaje: ");
      for I in 1 .. 94 loop
         Assert_True (getChar(mapVac, I) = ASCII.NUL );
      end loop;

     exception
         when Test_Assertion_Error => Put_Line (" Failed (assertion)");
         when others =>  Put_Line (" Failed!! (exception)");
   end Test_MapaVacio;


   procedure Test_VariosElementos is
      mapVac : map;
      xs : Keys(1 .. 6);
   begin

      initMap(mapVac);
      for I in 35 .. 40 loop
         put(mapVac, Character'Val(I),1);
      end loop;
      -- size --

      Assert_True (size(mapVac) = 6, "Prueba en mapa de 5 elementos");

      -- search --
      Put_Line("Prueba en mapa con 5 elementos de search, si hay error aparecera mensaje: ");
      for I in 35 .. 40 loop
            Assert_True (search(mapVac, Character'Val(I)) = I - 34);
      end loop;

      -- containsKey --
      Put_Line("Prueba en mapa con 5 elementos de containsKey, si hay error aparecera mensaje: ");
      for I in 35 .. 40 loop
            Assert_True (containsKey(mapVac, Character'Val(I)));
      end loop;

      -- get --
      Put_Line("Prueba en mapa con un elemento de get, si hay error aparecera mensaje: ");
      for I in 35 .. 40 loop
            Assert_True (get(mapVac, Character'Val(I)) = 1);
      end loop;

-- getList --
      xs := getList(mapVac);
      Assert_True (xs = ('#', '$', '%', '&', ''', '('), "Prueba en mapa con un elemento de getList");

      Put_Line("Prueba en mapa con un elemento de getChar, si hay error aparecera mensaje: ");
      for I in 1 .. 6 loop
            Assert_True (getChar(mapVac, I) = Character'Val(I + 34));
      end loop;


   exception
      when Test_Assertion_Error => Put_Line (" Failed!! (assertion)");
      when others =>  Put_Line (" Failed!! (exception)");

   end Test_VariosElementos;


   procedure Test_InsertCharOutOfRange is
      mapa : map;
      char : Character := ASCII.NUL;
   begin
      initMap(mapa);
      put(mapa, char, 1);
      exception
         when Constraint_Error => Put_Line ("Prueba error intentar insertar variable caracter fuera del rango 2: OK!! ;  Constraint alzada");
         when others =>  Put_Line ("Prueba error intentar insertar variable fuera del rango 2: Failed!! ; Constrain no alzada");
   end Test_InsertCharOutOfRange;

   procedure Test_ValueOutOfRange is
      mapa : map;
   begin
      initMap(mapa);
      put(mapa, 'x', -1);
      exception
         when Constraint_Error => Put_Line ("Prueba error intentar insertar valor fuera del rango : OK!! ;  Constraint alzada");
         when others =>  Put_Line ("Prueba error intentar insertar valor fuera del rango : Failed!! ; Constrain no alzada");
   end Test_ValueOutOfRange;


   procedure Test_SearchCharOutOfRange is
      mapa : map;
      char : Character := ASCII.NUL;
      index : Integer;
   begin
      initMap(mapa);
      index := search (mapa, char);
      exception
         when Constraint_Error => Put_Line ("Prueba error intentar buscar caracter fuera del rango : OK!! ;  Constraint alzada");
         when others =>  Put_Line ("Prueba error intentar buscar caracter fuera del rango : Failed!! ; Constrain no alzada");
   end Test_SearchCharOutOfRange;


   procedure Test_ContainsCharOutOfRange is
      mapa : map;
      char : Character := ASCII.NUL;
      state : Boolean;
   begin
      initMap(mapa);
      state := containsKey (mapa, char);
      exception
         when Constraint_Error => Put_Line ("Prueba error intentar buscar(Contains) caracter fuera del rango : OK!! ;  Constraint alzada");
         when others =>  Put_Line ("Prueba error intentar buscar(Contains) caracter fuera del rango : Failed!! ; Constrain no alzada");
   end Test_ContainsCharOutOfRange;


    procedure Test_GetCharOutOfRange is
      mapa : map;
      char : Character := ASCII.NUL;
      value : Integer;
   begin
      initMap(mapa);
      value := get (mapa, char);
      exception
         when Constraint_Error => Put_Line ("Prueba error intentar obtener(get) caracter fuera del rango : OK!! ;  Constraint alzada");
         when others =>  Put_Line ("Prueba error intentar obtener(get) caracter fuera del rango : Failed!! ; Constrain no alzada");
   end Test_GetCharOutOfRange;

   procedure Test_PutInitMap is
      mapa : map;
   begin
      put(mapa, 'x', 1);
   exception
      when SYSTEM.ASSERTIONS.ASSERT_FAILURE => Put_Line ("Prueba error al intentar insertar sin inicializar mapa: OK!! ;  Constraint alzada");
      when others =>  Put_Line ("Prueba error al intentar insertar sin inicializar mapa: Failed!! ; Constrain no alzada");
   end Test_PutInitMap;


   procedure Test_GetinitMap is
      mapa : map;
      value : Integer;
   begin
      value := get(mapa, 'x');
   exception
      when SYSTEM.ASSERTIONS.ASSERT_FAILURE => Put_Line ("Prueba error al intentar obtener(get) sin inicializar mapa: OK!! ;  Constraint alzada");
      when others =>  Put_Line ("Prueba error al intentar obtener(get) sin inicializar mapa: Failed!! ; Constrain no alzada");
   end Test_GetinitMap;

   procedure Test_SearchinitMap is
      mapa : map;
      index : Integer;
   begin
      index := search(mapa, 'x');
   exception
      when SYSTEM.ASSERTIONS.ASSERT_FAILURE => Put_Line ("Prueba error al intentar buscar sin inicializar mapa: OK!! ;  Constraint alzada");
      when others =>  Put_Line ("Prueba error al intentar buscar sin inicializar mapa: Failed!! ; Constrain no alzada");
   end Test_SearchinitMap;

   procedure Test_ContainsinitMap is
      mapa : map;
      state : Boolean;
   begin
      state := containsKey(mapa, 'x');
   exception
      when SYSTEM.ASSERTIONS.ASSERT_FAILURE => Put_Line ("Prueba error al intentar obtener(contains) sin inicializar mapa: OK!! ;  Constraint alzada");
      when others =>  Put_Line ("Prueba error al intentar obtener(contains) sin inicializar mapa: Failed!! ; Constrain no alzada");
   end Test_ContainsinitMap;


   procedure Test_GetListinitMap is
      mapa : map;
      claves : Keys(1 .. 94);
   begin
      claves := getList(mapa);
   exception
      when SYSTEM.ASSERTIONS.ASSERT_FAILURE => Put_Line ("Prueba error al intentar getList sin inicializar mapa: OK!! ;  Constraint alzada");
      when others =>  Put_Line ("Prueba error al intentar getList sin inicializar mapa: Failed!! ; Constrain no alzada");
   end Test_GetListinitMap;


   procedure Test_MapaLleno is
      map1 : map;
   begin
      initMap(map1);
      for I in 32..125 loop
         put(map1,Character'Val(I) ,1);
      end loop;

      Assert_True(size(map1) = 94, " Longitud actual es la maxima (94)");
      put(map1,Character'Val(126),1);
      Assert_True(size(map1) = 94 ,"Pueba de que si supera la longitud no se insertan");
      Assert_False(containsKey(map1,Character'Val(126)),"Pueba de que si supera la longitud no se insertan");


   exception
         when Test_Assertion_Error => Put_Line (" Failed (assertion)");
         when others =>  Put_Line (" Failed (exceotion)");
   end Test_MapaLleno;


begin

   New_Line;
   Put_Line("PRUEBAS DE MAPA VACIO----------------------------------------------");
   New_Line;
   Test_MapaVacio;

   New_Line;
   Put_Line("PRUEBAS DE MAPA CON Varios Elementos-------------------------------");
   New_Line;
   Test_VariosElementos;

   New_Line;
   Put_Line("PRUEBAS DE EJECUCIONES QUE DEBEN PRODUCIR EXCEPCION----------------");
   New_Line;
   Test_InsertCharOutOfRange;
   Test_ValueOutOfRange;
   Test_SearchCharOutOfRange;
   Test_ContainsCharOutOfRange;
   Test_GetCharOutOfRange;

   Test_PutInitMap;
   Test_GetinitMap;
   Test_ContainsinitMap;
   Test_SearchinitMap;
   Test_GetListinitMap;

   New_Line;
   Put_Line("PRUEBAS DE MAPA LLENO----------------------------------------------");
   New_Line;
   Test_MapaLleno;


end Main;
