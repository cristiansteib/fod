program ss;
uses crt;
const valorAlto=-1;

type 
	coches=record
		linea:integer;
		coche:integer;
		recaudacionMes:integer;
	   end;
	   
archivo=file of coches;


procedure importar(var a:archivo;var t:text);
	var 
		reg:coches;
	begin
	reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.linea,reg.coche,reg.recaudacionMes);
			write(a,reg);
		end;
		close(a);close(t);
	end;


procedure reporte(var a:archivo);
	var
		coche:coches;
		cocheMayorRecaudacion,mayorRecaudacion,linea:integer;
		lineaMayorRecaudacion,lineaRecaudacion:integer;
		totLinea,totCoches,totEmpresa,cantLineas:integer;
	begin
		cantLineas:=0;
		lineaRecaudacion:=0;
		totEmpresa:=0;
		reset(a);
		read(a,coche);                 //no uso el proceso leer,ya que finaliza todo con -1 en el archivo
		while coche.linea<> -1 do begin
			mayorRecaudacion:=0;
			totLinea:=0;
			totCoches:=0;
			linea:=coche.linea;
			Writeln;
			Writeln('Numero de Linea: ',linea);
			
			while ( (coche.linea=linea) AND (coche.linea<>-1) )do begin
				
				
				if coche.recaudacionMes> mayorRecaudacion then begin
					mayorRecaudacion:=coche.recaudacionMes;
					cocheMayorRecaudacion:=coche.coche;
				end;
				totCoches:=totCoches+1;
				totLinea:=totLinea+coche.recaudacionMes;
				read(a,coche);
			
			end;
			
			if totLinea>lineaRecaudacion then begin
				lineaRecaudacion:=totLinea;
				lineaMayorRecaudacion:=linea;
			end;
			
			totEmpresa:=totEmpresa + totLinea;
			cantLineas:=cantLineas+1;
			
			Writeln('Total recaudado por la linea: $',totLinea);
			
			Writeln('Promedio de recaudacion: $',totLinea DIV totCoches  );
	
			Writeln('Coche de mayor recaudacion n°: ',cocheMayorRecaudacion,' $',mayorRecaudacion);
			
			
			
		end;
		writeln;
		Writeln('-----------------------------------------------------');
		Writeln('-----------------------------------------------------');
		Writeln('La Linea con mayor recaudacion es : ',lineaMayorRecaudacion,' $',lineaRecaudacion );
		Writeln('Total recaudado por la empresa $',totEmpresa);
		Writeln('Recaudacion promedio de las lineas: $',totEmpresa DIV cantLineas);
		Writeln('-----------------------------------------------------');
		Writeln('-----------------------------------------------------');
		
		
	end;




var	
	fileName:string;
	t:text;
	a:archivo;

begin

	writeln;
	write('Nombre del archivo : ');readln(fileName);
	assign(t,fileName);
	assign(a,'coches.bin');
	importar(a,t);
	reporte(a);


end.
