{
* Author= Cristian Steib
* }

program untitled;
uses crt;

type
	archivoReales = file of real;


procedure a_crear_cargar(var archivo:archivoReales);
	var numero:real; total,i:integer;
	
	begin
		rewrite(archivo);
		write ('Cantidad de numeros que va a ingresar: ' );readln(total);
		for i:=1 to total do
		begin
			write('Numero: ');readln(numero);
			write(archivo,numero);
		end;
		close (archivo);
	end;
	

procedure mostrar_10xlinea(var archivo:archivoReales);
	var
		i:integer;
		numero:real;
	begin
		reset(archivo);
		read(archivo,numero);
		while (NOT eof(archivo)) do begin
			for i:=0 to 10 do begin
				if (NOT eof(archivo)) then begin
					write(numero:2:3,'  ');
					read(archivo,numero);
					end;
			end;
			writeln();
		end;
		close (archivo);
	end;


procedure listar_promedios(var archivo:archivoReales);
	var
		countTotal,countNeg,countPos : integer;
		numero,sumTotal,sumNeg,sumPos: real;
		
	begin
		countTotal:=0;
		countNeg:=0;
		countPos:=0;
		sumTotal:=0;
		sumNeg:=0;
		sumPos:=0;
		
		reset (archivo);
		read(archivo,numero);
		while (NOT eof(archivo)) do begin
			sumTotal:=sumTotal+numero;
			countTotal:=countTotal+1;
			if numero<0 then begin
				countNeg:=countNeg+1;
				sumNeg:=sumNeg+numero;
			end
			else begin
				countPos:=countPos+1;
				sumPos:=sumPos+numero;
			end;
			read(archivo,numero);
		end;
		writeln('Cantidad de negativos:',countNeg);
		writeln('Cantidad de positivos:',countPos);
		writeln('Cantidad total de numeros:',countTotal);
		writeln('Promedio de numeros negativos: ',sumNeg / countNeg);
		writeln('Promedio de numeros positivos: ',sumPos / countPos);
		writeln('Promedio total: ',sumTotal / countTotal);
			{ se podria haber sumado la cant de pos y negativos para saber el total, y sumas los pos + los neg para tener la 
			* suma total.  }	
	end;


var
	opcion:byte;
	fileName:string;
	archivo:archivoReales;
BEGIN

	writeln('MENU:');
	writeln('1) Crear archivo de numeros reales.'); 
	writeln('2) Mostras numero, 10 x linea.'); 
	writeln('3) Listar cantida de negativos,promedios,y mas.');
	writeln('');
	write('Opcion: ');readln(opcion);
	writeln ('');
	writeln('nombre del archivo');
	readln(fileName);
	assign (archivo,fileName);
			
	while (opcion <> 0) do begin
	clrscr;
		case opcion of 
			1: a_crear_cargar(archivo);
			2: mostrar_10xlinea(archivo);
			3:listar_promedios(archivo);
		end;
	clrscr;
	writeln('MENU:');
	writeln('1) Crear archivo de numeros reales.'); 
	writeln('2) Mostras numero, 10 x linea.'); 
	writeln('3) Listar cantida de negativos,promedios,y mas.');
	writeln('');
	write('Opcion: ');readln(opcion);
	writeln ('');
	end;
		
	


	
END.

