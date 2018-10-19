-- Paquete de mapa de caracteres
-- funciones:
--           - put (mapa, char, value);
--           - containsKey (mapa, char) return Boolean;
--           - get (mapa, char) return value;
--           - getList (mapa) return Keys;
--           - getChar (mapa, index) return Character;
--           - initMap (mapa);

package MapaCharacters with SPARK_Mode is

   subtype Character_Range is Character range ' ' .. '~';

   type Keys is array (Positive range <>) of Character_Range;


   type Value is array (Positive range <>) of Natural;

   subtype map_Range is Natural range 0 .. 94;


   type map is private;
-- Metodos para acceder a los atributos de record mapa y utilizarlos para la verificacion formal
   function size (mapa : map) return map_Range;
   function claves (mapa : map) return Keys;
   function valores (mapa : map) return Value;
   function is_Init (mapa : map) return Boolean;


   function areDiferent (mapa : map) return Boolean is
      (for all I in 1 .. size(mapa) =>
          (for all J in 1 .. size(mapa) =>
               (if I < J then claves(mapa)(I) /= claves(mapa)(J))));


   -- Comprueba que solo se modifican cierto elementos
   function stayTheSame (mapa : map; mapaOld : map; exclude : Boolean; index : Natural) return Boolean is
     (if index in 1 ..  map_Range'Last then
          (for all I in 1 ..  size(mapaOld) =>
                (if exclude  and then claves(mapa)(index) /= claves(mapa)(I) then
                     claves(mapaOld)(I) = claves(mapa)(I) and
                     valores(mapaOld)(I) = valores(mapa)(I))));



   -- Busca el elemento en el mapa
   -- Esta publico con el objetivo de utilizarlo para la verificacion

   function search (mapa : map; char : Character_Range) return map_Range
     with
       Global => null,
       Depends => (search'Result => (mapa, char)),
       Pre => is_Init(mapa),
       Post =>
         (if search'Result in 1 .. size(mapa) then
             claves(mapa)(search'Result) = char
         else
             search'Result = 0 and
             (for all I in 1 ..  size(mapa) => claves(mapa)(I) /= char));


   -- inicializa el mapa
   procedure initMap(mapa : in out map) with
     Pre => True,
     Post => is_Init (mapa) and size(mapa) = 0;


   -- devuelve verdadero si la clave esta en el mapa
   -- falso de forma contraria

   function containsKey (mapa : map; char : Character_Range) return Boolean
     with
       Global => null,
       Depends => (containsKey'Result => (mapa, char)),
       Pre => is_Init(mapa),
       Post => (if containsKey'Result then
                  (for some I in 1 ..  size(mapa) => claves(mapa)(I) = char)
               else
                  (for all I in 1 ..  size(mapa) => claves(mapa)(I) /= char));


   -- devuelve el valor de la clave si esta esta en el mapa
   -- devuelve -1 en caso contrario

   function get (mapa : map; char : Character_Range) return Integer
     with
       Global => null,
       Depends => (get'Result => (mapa, char)),
       Pre => is_Init(mapa),
       Post =>
          (if get'Result in Natural then
              (for some I in 1 ..  size(mapa) => claves(mapa)(I) = char and valores(mapa)(I) = get'Result)
           else
              get'Result = -1);

   -- introduce el elemento en el mapa si no esta y si el mapa no esta llevo
   -- actualiza su valor si la clave ya esta en el mapa

   procedure put (mapa : in out map ; char : Character_Range; value : Natural)
     with
       Global => null,
       Pre => is_Init(mapa) and areDiferent(mapa),
       Post =>   areDiferent(mapa) and then
         ((if size (mapa'Old) = size(mapa) then
             (if search(mapa, char) in 1 .. size(mapa) then
                  claves(mapa)(search(mapa, char)) = char and
                  valores(mapa)(search(mapa, char)) = value and
                  stayTheSame(mapa, mapa'Old, True, search(mapa, char))
             else
                  stayTheSame(mapa, mapa'Old, False, 1))
         else
             stayTheSame(mapa, mapa'Old, False, 1) and
             size(mapa) = size(mapa'Old) + 1 and
             claves(mapa)(size(mapa)) = char and
             valores(mapa)(size(mapa)) = value));


   -- devuelve un array del tipo Keys con tamaño igual a la cantidad de elementos que tiene el mapa
   -- y con los elementos que contiene

   function getList (mapa : map) return Keys with
     Global => null,
     Depends => (getList'Result => mapa),
     Pre  =>  is_Init(mapa),
     Post => (for all I in 1 .. size(mapa) =>
                  getList'Result(I) = claves(mapa)(I));



   -- devuelve la clave que esta en la posicion pasada por paramentro si esta en el rango del mapa
   -- devuelve ASCII.NUl en caso contrario

   function getChar (mapa : map; index : Integer) return Character with
     Pre => is_Init(mapa),
     Contract_Cases =>
       ((index in 1 .. size(mapa)) => getChar'Result = claves(mapa)(index),
        others                    => getChar'Result = ASCII.NUL);


private

   type map is record
      claves : Keys(1 .. 94);
      valores : Value(1 .. 94);
      length : map_Range := 0;
      init : Boolean := False;
   end record;

   function size (mapa : map) return map_Range is (mapa.length);
   function claves (mapa : map) return Keys is (mapa.claves);
   function valores (mapa : map) return Value is (mapa.valores);
   function is_Init (mapa : map) return Boolean is (mapa.init);

 end MapaCharacters;

