class Carta
	attr_reader :pinta,:numero
	def initialize(pinta, numero)
		@pinta = pinta 
		@numero = numero
	end

end

def jugar
	pintas=["Corazones","Diamante","Picas","Treboles"]
	cartas=[]
	i=0
	while i<5 do
		cartas.push(Carta.new( pintas[rand(0..3)] , rand(1..13) ))  
		i+=1
	end
	return cartas
end

def guardar(cartas)
	archivo =File.open("Cartas.txt", 'w')
	i=0
	while(i<cartas.length)
		archivo.puts(imprimir(cartas[i]))
		i+=1
	end
	archivo.close
end 

def imprimir(carta)
	case carta.numero
		when 1
			"AS de #{carta.pinta}"
		when 11
			"Jack de #{carta.pinta}"
		when 12
			"Reina de #{carta.pinta}"
		when 13 
			"Rey de #{carta.pinta}"	
		else 
			"#{carta.numero} de #{carta.pinta}"				
	end
end


def mostrar(cartas)
	i=0
	while i<cartas.length
		puts imprimir (cartas[i]) 
		i+=1
	end
end

def leer(nombreArchivo)
	archivo = File.open(nombreArchivo,"r")
	contenido =[]
	archivo.each_line do |line|
		contenido.push(line.chomp.split(" ")) 
	end
	print contenido

	i=0
	cartas=[]
	while(i<contenido.length)
		case contenido[i][0]
			when "AS"
				cartas.push(Carta.new(contenido[i][2],1))
			when "Jack"
				cartas.push(Carta.new(contenido[i][2],11))
			when "Reina"
				cartas.push(Carta.new(contenido[i][2],12))
			when "Rey" 
				cartas.push(Carta.new(contenido[i][2],13))
			else 
				cartas.push(Carta.new(contenido[i][2] ,contenido[i][0]))
		end
		i+=1
	end
	archivo.close
	return cartas
end

# cartas=jugar
# print mostrar(cartas)
# guardar(cartas)
# print  leer("Cartas.txt")

opcion=""
cartas=[]

while(opcion.downcase!="salir")
	puts "ingrese la opcion: "
	puts "mostrar: para mostrar las cartas generadas por jugar"
	puts "guardar: para guardar las cartas generadas por jugar"
	puts "leer: para cargar cartas desde un archivo"
	puts "salir: para finalizar la ejecucion del programa"

	opcion = gets.chomp
	case opcion
		when "jugar"
			cartas = jugar  
			puts "se han generado correctamente las cartas"
		when "guardar"
			if(cartas.empty?)
				puts "No hay cartas para guardar"
			else
				guardar(cartas)
			end
		when "mostrar"
			if(cartas.empty?)
				puts "no hay cartas para mostrar"
			else
				mostrar(cartas)
			end
		when "leer"
			puts "ingrese nombre de archivo a leer (con extension)"
			nombre = gets.chomp
			leer(nombre)
	end
end
