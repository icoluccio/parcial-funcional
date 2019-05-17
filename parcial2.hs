import Text.Show.Functions
type Requisito = Propiedad  -> Bool
type Busqueda = [Requisito]
data Propiedad = Depto {
 ambientes::Int, 
 superficie::Int, 
 precio::Float, 
 barrio::String}
data Usuario = Persona {
 mail::String, 
 busqueda::Busqueda }


ordenarSegun :: (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) = (ordenarSegun criterio.filter (not.criterio x)) xs ++ [x] ++ (ordenarSegun criterio.filter (criterio x)) xs

between x y z = x <= z && y >= z


-- 1
mayor funcion a b = funcion a > funcion b

-- 1a
-- ordenarSegun (criterio) lista, donde criterio espera 2 elementos y devuelve booleano
-- mayor espera un criterio y 2 elementos -> aplicación parcial
-- ordenarSegun (mayor id) [1,2,3]

-- 2
ubicadoEn listaDeBarrios departamento = any (==(barrio departamento)) listaDeBarrios
--ver esto
cumpleRango funcion a b departamento = ((funcion departamento) > a) && ((funcion departamento) < b)

-- 3a
cumpleBusqueda busqueda departamento = all ($ departamento) busqueda
-- 3b
buscar busqueda criterioDeOrdenamiento listaDeDepartamentos =
    ordenarSegun criterioDeOrdenamiento
                  (filter (cumpleBusqueda busqueda) listaDeDepartamentos)
--3c
propiedadesDeEjemplo::[Propiedad ]
propiedadesDeEjemplo = [Depto 3 80 12500 "Palermo", Depto 1 45 10000 "Villa  Urquiza", Depto 2 50 16000 "Palermo", Depto 1 45 10500 "Recoleta"]
-- buscar [ubicadoEn ["Recoleta", "Palermo"], (<3).ambientes, (<6000).precio ] (mayor superficie) departamentos

-- 4
mailsDePersonasInteresadas:: Propiedad->[Usuario]->[String]
mailsDePersonasInteresadas departamento personas = (map mail.filter (flip cumpleBusqueda departamento.busqueda)) personas

--cumpleAlgunaBusquedaPara::Propiedad ->Usuario->Bool
--cumpleAlgunaBusquedaPara departamento persona =  cumpleBusqueda departamento) (busqueda persona)
-- 4 prueba

personasDeEjemplo::[Usuario]
personasDeEjemplo = [Persona "hola@hola.com" [ubicadoEn ["Algun lado"]], Persona "hola2@hola2.com" [ubicadoEn ["Recoleta", "Palermo"], (<3).ambientes, (<6000).precio ], Persona "hola3@hola.com" [ubicadoEn ["Recoleta", "Palermo"], (<3).ambientes, (<6000).precio]]
-- mailsDePersonasInteresadas (head departamentos) personas
