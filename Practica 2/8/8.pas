program ss;
uses crt;
const valorAlto=-1;

type 
	coches=record
		zona:integer;
		linea:integer;
		coche:integer;
		dia:integer;
		recDia:integer;
	   end;
	   
archivo=file of coches;


procedure importar(var a:archivo;var t:text);
	var 
		reg:coches;
	begin
	reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.zona, reg.linea,reg.coche,reg.dia ,reg.recDia);
			write(a,reg);
		end;
		close(a);close(t);
	end;


procedure reporte(var a:archivo);
	var
		reg:coches;
		linea,coche,zona:integer;
		totCoche,cantCoche,totLinea:integer;
		lineaMayRec,totLineaMayRec:integer;
		totEmpresa,cantLineas,zonaMayorLineas,cantZonaMayorLineas:integer;
	begin
		reset(a);
		read(a,reg);
		totLineaMayRec:=0;
		totEmpresa:=0;
		cantZonaMayorLineas:=0;
		while reg.zona<>-1 do begin
			
			zona:=reg.zona;
			Writeln('********************************************');
			Writeln('ZONA: ',zona);
			cantLineas:=0;
			while ((reg.zona=zona ) AND (reg.zona<>-1) )do begin
				
				
				
				linea:=reg.linea;
				totLinea:=0;
				Writeln;
				Writeln('Numero de linea ',linea);
						
				while ( (reg.linea = linea) AND (reg.zona<>-1) ) do begin
					
					totCoche:=0;
					cantCoche:=0;
					coche:=reg.coche;
					
					
					while( (reg.coche=coche) AND (reg.linea = linea) AND (reg.zona<>-1) ) do begin
						cantCoche:=cantCoche+1;
						totCoche:=totCoche+reg.recDia;
						read(a,reg);
					end;	
								
					Writeln('Coche: ',coche,' Recaudacion Mensual: $',totCoche);
					totLinea:=totLinea+totCoche;
					
				end;
				
				
				cantLineas:=cantLineas+1;
				totEmpresa:=totEmpresa+totLinea;
				Writeln('Recaudacion promedio: $',totLinea DIV cantCoche);
				
				if totLineaMayRec<totLinea then begin
					totLineaMayRec:=totLinea;
					lineaMayRec:=linea;
				end;
				

		
			end;
			if cantLineas>cantZonaMayorLineas then begin
				cantZonaMayorLineas:=cantLineas;
				zonaMayorLineas:=zona;
			end;
			
			Writeln('Linea de mayor recaduacion para la zona: ',lineaMayRec, ' $',totLineaMayRec);
			Writeln;
		end;
		writeln;
		writeln('--------------------------------------------------------------------------');
		Writeln('Recaudacion total para la empresa: $',totEmpresa);
		Writeln('Zona ',zonaMayorLineas,' con mayor lineas trabajando, con ',cantZonaMayorLineas,' lineas');
		writeln('--------------------------------------------------------------------------');
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
