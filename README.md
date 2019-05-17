# LamdaProp

![](lambdaprop.jpg)

*Buscar departamentos para alquilar por los medios tradicionales es una tarea compleja, ya que requiere mucho tiempo de investigación buscando en los clasificados de los diarios y recorriendo inmobiliarias. Es por eso que hoy en día cada vez son más las personas que dejaron eso atrás dejando que la tecnología les ayude a buscar las supuestas mejores alternativas para sus necesidades.
Por eso surge una nueva aplicación para buscar departamentos que permite al usuario personalizar su búsqueda y de paso eventualmente recibir las nuevas ofertas inmobiliarias que podrían ser de su interés, a ver si agarra viaje.*

Tenemos la información que maneja el sistema modelada de la siguiente forma:

~~~Haskell
type Requisito = Depto -> Bool
type Busqueda = [Requisito]
data Propiedad = Depto {
  ambientes::Int, 
  superficie::Int, 
  precio::Float, 
  barrio::String}
data Usuario = Persona {
  mail::String, 
  busqueda::Busqueda }
~~~

A su vez disponemos de las siguientes funciones para usar en el desarrollo:

~~~Haskell
ordenarSegun :: (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) = (ordenarSegun criterio.filter (not.criterio x)) xs ++ [x] ++ (ordenarSegun criterio.filter (criterio x)) xs

between x y z = x <= z && y >= z

propiedadesDeEjemplo = [Depto 3 80 12500 "Palermo", Depto 1 45 10000 "Villa  Urquiza", Depto 2 50 16000 "Palermo", Depto 1 45 10500 "Recoleta"]
~~~


Se pide desarrollar las siguientes funciones y consultas de modo que se aprovechen tanto como sea posible los conceptos de orden superior, aplicación parcial y composición.

Definir la función mayorSegun que reciba una función y dos valores, y diga si el resultado de evaluar esa función sobre el primer valor es mayor que el resultado de evaluarlo sobre el segundo valor respectivamente.

Mostrar un ejemplo de cómo se usaría una de estas funciones para ordenar una lista de strings en base a su longitud usando ordenarSegun.

Definir las siguientes funciones para que puedan ser usadas como requisitos de búsqueda:
ubicadoEn que dada una lista de barrios que le interesan al usuario, retorne verdadero si el departamento se encuentra en alguno de los barrios de la lista.

cumpleRango que a partir de una función y dos números, indique si el valor retornado por la función al ser aplicada con el departamento se encuentra entre los dos valores indicados.


Definir la función 
cumpleBusqueda :: Propiedad-> Busqueda -> Bool 
que se cumple si todos los requisitos de la búsqueda se verifican para ese departamento.

Definir la función buscar que a partir de una búsqueda, un criterio de ordenamiento y una lista de propiedades retorne todas aquellas que cumplen con la búsqueda ordenados en base al criterio recibido.

Mostrar un ejemplo de uso de buscar para obtener los departamentos que se encuentren en Recoleta o Palermo de 1 a 2 ambientes que se alquilen entre $8000 y $15000 por mes, de modo que el resultado se encuentre ordenado por mayor superficie con la lista de propieades de ejemplo dada.

Definir la función mailsDePersonasInteresadas que a partir de un departamento y una lista de personas retorne los mails de las personas cuya búsqueda se adapta al departamento dado.

