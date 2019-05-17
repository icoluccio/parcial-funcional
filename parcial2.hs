import Text.Show.Functions
type Requisito = Depto -> Bool
type Busqueda = [Requisito]
type Depto = (Int, Int, Int, String)
type Persona = (String, [Busqueda])
ambientes (a, _,_,_) =a
superficie (_,m2,_,_) = m2
precio (_,_,p,_)= p
barrio (_,_,_,b) = b

mail persona = fst persona
busquedas persona = snd persona

ordenarSegun :: (a -> a -> Bool) -> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) = (ordenarSegun criterio.filter (not.criterio x)) xs ++ [x] ++ (ordenarSegun criterio.filter (criterio x)) xs

between x y z = x <= z && y >= z


-- 1
comparar funcionComparacion funcion a b = funcionComparacion (funcion a) (funcion b)
mayor funcion a b = comparar (>) funcion a b
menor funcion a b = comparar (<) funcion a b

-- 1a
-- ordenarSegun (criterio) lista, donde criterio espera 2 elementos y devuelve booleano
-- mayor espera un criterio y 2 elementos -> aplicación parcial
-- ordenarSegun (mayor id) [1,2,3]
-- ordenarSegun (menor (*5)) [1,2,3]

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
departamentos = [(1,2,3, "Recoleta"), (1,267,3, "Recoleta"), (1,2000,33, "Recoleta"), (1,20,300000, "Recoleta"), (1,20,300000, "Chacarita")]
-- buscar [ubicadoEn ["Recoleta", "Palermo"], (<3).ambientes, (<6000).precio ] (mayor superficie) departamentos

-- 4
mailsDePersonasInteresadas departamento listaDePersonas = (map mail) (filter (cumpleAlgunaBusquedaPara departamento) listaDePersonas)
cumpleAlgunaBusquedaPara departamento persona = any (flip cumpleBusqueda departamento) persona
-- 4 prueba
personas = [("hola@hola.com", [ubicadoEn ["Algun lado"]]), ("hola2@hola2.com", [ubicadoEn ["Recoleta", "Palermo"], (<3).ambientes, (<6000).precio ]), ("hola3@hola.com", [ubicadoEn ["Recoleta", "Palermo"], (<3).ambientes, (<6000).precio])]
-- mailsDePersonasInteresadas (head departamentos) personas
