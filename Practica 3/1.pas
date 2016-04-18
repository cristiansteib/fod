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


procedure cargar_registro(var reg:producto);
	begin
		write('Nombre: ');readln(reg.nombre);
		if reg.nombre<>'' then begin
			write('codigo: ');readln (reg.codigo);
			write('cantidad actual: ');readln (reg.cantActual);
			write('cantidad minima: ');readln (reg.cantMinima);
			write('cantidad maxima: ');readln (reg.cantMax);
			write('precio: ');readln (reg.precio);
			writeln();
		end;
	end;
	


procedure cargar_c_cabecera(var archivo:archivoProducto);
	var
	reg:producto;
	begin		
		rewrite(archivo);
		reg.codigo:=0;
		write(archivo,reg);
		readln();
		cargar_registro(reg);
		while (reg.nombre <> '') do 
			begin
				write(archivo,reg);
				cargar_registro(reg);
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
		cargar_registro(regNue);
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
		reg,cabe:producto;
		codigo:integer;

	begin
		reset(archivo);
		write('Ingrese codigo a borrar: '); readln(codigo);
		leer (archivo,reg);
		cabe:=reg;
		while (reg.codigo<>codigo) AND (reg.codigo<>valorAlto) do begin leer(archivo,reg); end;
		if reg.codigo<>valorAlto then begin
			seek(archivo,filepos(archivo)-1);
			reg.codigo:=(filepos(archivo))*-1;
			write(archivo,cabe);
			seek(archivo,0);
			write(archivo,reg);
			end
		else writeln('no se encontro el archivo');
		close (archivo);
	end;



	
procedure modificar(var archivo:archivoProducto);
var
	regNue,reg:producto;
	
	begin
	reset(archivo);
	clrscr;
	writeln ('Codigo de producto a modificar: ');readln(regNue.codigo);
	leer(archivo,reg);
	while (reg.codigo <> regNue.codigo)AND (reg.codigo<>valorAlto) do begin
		leer (archivo,reg);
		end;
	
	if reg.codigo <> valorAlto then begin
		seek(archivo,filepos(archivo)-1);
		write('Nombre: ');read(reg.nombre);
		write('cantidad actual: ');readln (reg.cantActual);
		write('cantidad minima: ');readln (reg.cantMinima);
		write('cantidad maxima: ');readln (reg.cantMax);
		write('precio: ');readln (reg.precio);
		write (archivo,reg);
		end
	else
		writeln('no se encontro el codigo');
	close(archivo);
		
	
	end;
	
			
var 
	opcion : byte;
	fileName:string;
	archivo:archivoProducto;

BEGIN	
	writeln('Menu:');
	writeln('1 = Crear archivo y cargarlo.');
	writeln('2 = Mantenimiento de archivo.');
	writeln('3 = Recorrer archivo.');
	writeln();
	repeat 
	writeln();
	write('Opcion : ');readln(opcion);
	case opcion of 
		1 : begin
			clrscr;
			writeln ('Ingrese nombre del archivo: ');read(fileName);
			assign(archivo,fileName);
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
				1:alta(archivo);
				2:modificar(archivo);
				3:borrado(archivo);
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
	until opcion=0;
END.

