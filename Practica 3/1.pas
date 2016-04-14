{
* Author= Cristian Steib
* 
* }

program untitled;
uses crt;
const valorAlto = 9999;

type 
	producto = RECORD 
		codigo:integer;
		nombre:string;
		cantActual:integer;
		cantMinima:integer;
		cantMax:integer;
		precio:real;
		end;

archivoProducto = file of producto;



procedure leer(var a:archivoProducto;var reg:producto);
	begin
		if (NOT eof(a)) then
			read (a,reg)
		else
			reg.codigo:=valorAlto;	
	end;



procedure cargar_c_cabecera(var archivo:archivoProducto);
	var
	reg:producto;
	begin		
		reset(archivo);
		with reg do begin 
			codigo:=0;
			write(archivo,reg);
			write('Nombre: ');readln(nombre);readln(nombre);
			while (nombre <> ' ') do 
				begin
				write('codigo: ');readln (codigo);
				write('cantidad actual: ');readln (cantActual);
				write('cantidad minima: ');readln (cantMinima);
				write('cantidad maxima: ');readln (cantMax);
				write('precio: ');readln (precio);
				write(archivo,reg);
				writeln();
				write('Nombre: ');read(nombre);
				end;
		end;				

		close (archivo);
	end;



procedure recorrer(var archivo:archivoProducto ) ;
	var
		reg : producto;
		
	begin
		reset (archivo);
		leer (archivo, reg);
		while (reg.codigo<>valorAlto) do 
			begin
			write(reg.nombre,' '); write(reg.codigo,' '); write (reg.cantActual,'  '); write (reg.cantMinima,'  ');write (reg.precio:2:2,'  '); writeln(reg.cantMax);
			leer (archivo,reg);
			end;
		close (archivo);
	end;
	



procedure alta(var archivo:archivoProducto);
var 
	reg :producto;
	regNue :producto;
	
	begin
		reset(archivo);
		with regNue do begin
			write('Nombre: ');read(nombre);
			write('codigo: ');readln (codigo);
			write('cantidad actual: ');readln (cantActual);
			write('cantidad minima: ');readln (cantMinima);
			write('cantidad maxima: ');readln (cantMax);
			write('precio: ');readln (precio);
		end;
		read(archivo,reg);		
		if (reg.codigo<=-1) then
			begin
				seek(archivo,reg.codigo*-1);
				leer(archivo,reg);
				seek(archivo,filepos(archivo)-1);
				write(archivo,regNue);
				seek (archivo,0);
				write(archivo,reg);		
			end
		else begin
			seek(archivo,filesize(archivo));
			write(archivo,regNue);
			end;
			close(archivo);
	end;
	
procedure borrado(var archivo:archivoProducto);
	var
		reg:producto;
		codigo:integer;
		cabecera:integer;
	begin
		reset(archivo);
		
		write('Ingrese codigo a borrar: '); readln(codigo);
		leer (archivo,reg);
		cabecera:=reg.codigo;
		while (reg.codigo<>codigo) do begin leer(archivo,reg); end;
		if reg.codigo<>valorAlto then begin
			
			seek(archivo,filepos(archivo)-1);
			reg.codigo:=cabecera;
			write(archivo,reg);
			cabecera:=(filepos(archivo)-1)*-1;

			seek(archivo,0);
			leer (archivo,reg);
			reg.codigo:=cabecera;
			seek(archivo,0);
			write(archivo,reg);
			end;
		
	end;



	
procedure modificar(var archivo:archivoProducto);
var
	regNue,reg:producto;
	
	begin
	reset(archivo);
	clrscr;
	writeln ('Codigo de producto a modificar: ');readln(regNue.codigo);
	leer(archivo,reg);
	while (reg.codigo <> regNue.codigo) do begin
		leer (archivo,reg);
		end;
	if reg.codigo <> valorAlto then begin
		write('Nombre: ');read(reg.nombre);
		write('cantidad actual: ');readln (reg.cantActual);
		write('cantidad minima: ');readln (reg.cantMinima);
		write('cantidad maxima: ');readln (reg.cantMax);
		write('precio: ');readln (reg.precio);
		seek(archivo,filepos(archivo)-1);
		write (archivo,reg);
		end
	else
		writeln('no se encontro el codigo');
	end;
	
		

			
		
var opcion : byte;
fileName:string;
archivo:archivoProducto;





BEGIN
	
	writeln('Menu:');
	writeln('1 = Crear archivo y cargarlo.');
	writeln('2 = Mantenimiento de archivo.');
	writeln('3 = Recorrer archivo.');
	
	writeln();
	opcion:=9;
	while (opcion<>0) do begin
	writeln();
	write('Opcion : ');readln(opcion);
	case opcion of 
		1 : begin
				clrscr;
				writeln ('Ingrese nombre del archivo: ');read(fileName);
				assign(archivo,fileName);
				rewrite(archivo);
				close(archivo);
				cargar_c_cabecera(archivo);
			end;
		2 : begin
				clrscr;
				writeln ('Ingrese nombre del archivo a abrir: ');read(fileName);
				assign(archivo,fileName);
				clrscr;
				writeln();
				writeln('Menu Mantenimiento: ');
				writeln('1= alta');
				writeln('2= modificar datos');
				writeln('3= borrar dato');
				write('Opcion : ');readln(opcion);
				case opcion of 
				
					1:begin
						alta(archivo);
					end;
					
					2:begin
						modificar(archivo);
					end;
					3:begin
						borrado(archivo);
					end;
					
					
					
				end;
			
			
			end;
			
		3 : begin
			clrscr;
			writeln ('Ingrese nombre del archivo a recorrer: ');read(fileName);
			assign(archivo,fileName);
			recorrer(archivo);
			end;
			
			
	end;
	readkey;
	clrscr;
	writeln('Menu:');
	writeln('1 = Crear archivo y cargarlo.');
	writeln('2 = Mantenimiento de archivo.');
	writeln('3 = Recorrer archivo.');
	
	writeln();
	
	end;
	
	
END.

