#Autor: Rojas de la Rosa Carlos Armando
#Programa que multiplica dos números por el metodo de karatsuba utilizando la multiplicación clásica
#los numeros deben colocarse de mayor a menor
$x = [1,2,3,4]
$y = [0,0,2,5]
$a = Array.new
$b = Array.new
$c = Array.new
$d = Array.new
$N1 = 4
$ac10 = [0,0,0,0]
$bd = [0,0,0,0]
$aMasB = [0,0,0]
$cMasD = [0,0,0]
$aPorC = [0,0,0,0]
$bPorD = [0,0,0,0]
$ad_bc = [0,0,0,0]
$acMasbd = [0,0,0,0,0,0,0,0]
$producto = [0,0,0,0,0,0,0,0]
$resultado = [0,0,0,0,0,0,0,0]
class Karatsuba

#Constructor
    def initialize()
    end

#Funcion para obtener el segmento correspondiente de a,b,c y d
    def obtenerValores()
        
        mitadX = $x.length / 2
        #obtenienedo a
        $a = $x.slice(0,mitadX)
        $a = $a.reverse
        
        #obteniendo b
        $b = $x.slice(mitadX,$x.length)
        $b = $b.reverse
        
        #obteniendo c
        mitadY = $y.length / 2
        $c = $y.slice(0,mitadY)
        $c = $c.reverse
       
        #obteniendo d
        $d = $y.slice(mitadY,$y.length)
        $d = $d.reverse
        
        
    end
#Funcion para obtener la multiplicación clasica
    def multiplicacion(numero1,numero2,indice,resultado)
        acarreo = 0
        aux = []
        temporal = 0
    #para la multiplicacion
        i = 0
        while i < numero1.length
            temporal = numero1[i] * numero2 + acarreo
            acarreo = temporal / 10
            temporal = temporal % 10
            aux[i] = temporal;
            i = i+1
        end
            aux.push(acarreo)
            acarreo = 0
            
        #para la suma

        j = 0
        
        while j < numero1.length + 1
            
            temporal = aux[j] + resultado[j+indice] + acarreo
            acarreo = temporal / 10
            temporal = temporal % 10
            resultado[j+indice] = temporal
            j = j+1
        end
        
    end

    def imprimir(numero)
        print numero.reverse()
    end

    def iterar()
        i = 0
        #obtenemos el producto de ac * 10 **4
        while i < $c.length
            multiplicacion($a,$c[i],i,$ac10)
            i = i + 1
        end
        i = 0
        while i < $N1
            $ac10.insert(0,0)
            i = i+1
        end
        #obtenemos el producto entre bd
        i = 0
        while i < $d.length
            multiplicacion($b,$d[i],i,$bd)
            i = i + 1
        end
        #obtenemos (ad)+(bc)
            #suma de a + b
            suma($a,$b,$aMasB)
            #suma de c + d
            suma($c,$d,$cMasD)
            #a * c
            i = 0
            while i < $c.length
                multiplicacion($a,$c[i],i,$aPorC)
                i = i + 1
            end
            
            #b * d
            i = 0
            while i < $b.length
                multiplicacion($b,$d[i],i,$bPorD)
                i = i + 1
            end
            
            #ac + bd
            suma($aPorC,$bPorD,$acMasbd)
            

            #producto = (a+b)*(c+d)
            i = 0
            while i < $cMasD.length
                multiplicacion($aMasB,$cMasD[i],i,$producto)
                i = i + 1
            end
            
            #ad_bc = producto - acMasbd
            resta($producto,$acMasbd,$ad_bc)
            
            # ad_bc * 10**N/2
                i = 0
                while i < $N1/2
                    $ad_bc.insert(0,0)
                    i = i + 1
                end
            
           # resultado = ac10 + bPorD + ad_bc
           #rellenamos con ceros por delante a bPorD para que tenga la misma longitud que ac10
           i = $bPorD.length
            while i < $ac10.length
                $bPorD.push(0)
                i = i + 1
            end
            
            
            #suma ac10 + bPorD
            suma($ac10,$bPorD,$resultado)

            #rellenamos con ceros por delante a ad_bc para que tenga la misma longitud que resultado
            i = $ad_bc.length
                while i < $resultado.length
                    $ad_bc.push(0)
                    i = i + 1
                end
            resultadoFinal = [0,0,0,0,0,0,0,0]
            suma($resultado,$ad_bc,resultadoFinal)
            print "resultado:"
                imprimir(resultadoFinal)
            
    end

    def suma(numero1,numero2,resultado)
        j = 0
        acarreo = 0
        while j < numero1.length
            temporal = numero1[j] + numero2[j] + acarreo  
            acarreo = temporal / 10
            temporal = temporal % 10
            resultado[j] = temporal
            
            j = j+1
        end
        resultado[j] = acarreo
    end
#Funcion para restar los numeros de dos arreglos
    def resta(numero1,numero2,resultado)
        i = 0
        temporal = 0
        acarreo = 0
        while i < numero1.length
            #comprobamos que el digito i del numero1 sea mayor o igual que el digito i del numero2
            if numero1[i] >= numero2[i]
                temporal = numero1[i]- acarreo - numero2[i]
                acarreo = 0
                resultado[i] = temporal
            else
                acarreo = 1
                numero1[i] = numero1[i] + 10
                temporal = numero1[i] - numero2[i]
                resultado[i] = temporal
            end
            i = i + 1
        end
    end

    def llenarConCeros(numeroChico,numeroGrande)
        i = 0
        
    end

end

k = Karatsuba.new()
k.obtenerValores()
k.iterar()
