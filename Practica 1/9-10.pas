{
Author = Cristian Steib
   
   
}


program untitled;

uses crt;
type 
	
	productos = record
		codigo:integer;
		nombre:string;
		stActual:integer;
		stMinimo:integer;
		precio:real;
		end;


archivoProducto = file of productos;


procedure cargar_registro(var reg:productos);
	begin
		write('codigo: '); readln(reg.codigo);
		if (reg.codigo<>0) then begin 
			write('nombre: '); readln(reg.nombre);
			write('stActual: '); readln(reg.stActual);
			write('stMinimo: '); readln(reg.stMinimo);
			write('precio: '); readln(reg.precio);
		end;
	end;
	

procedure crear_archivo(var archivo:archivoProducto);
	var
		regNue:productos;
	begin
		rewrite(archivo);
		cargar_registro(regNue);
		while (regNue.codigo<>0) do begin
			write(archivo,regNue);
			cargar_registro(regNue);
		end;	
		close(archivo);	
	end;



procedure debajo_stock_minimo(var archivo:archivoProducto);
	var
		reg:productos;
	begin
		reset (archivo);
		read (archivo,reg);
		while (not eof(archivo)) do begin
			if reg.stActual<reg.stMinimo then writeln('Esta por debajo del stock minimo :',reg.nombre,' --- ',reg.nombre);
			read(archivo,reg);
		end;
	end;

procedure incrementar_precio(var archivo:archivoProducto);
	var
		reg:productos;
	begin
		reset (archivo);
		read (archivo,reg);
		while (not eof(archivo)) do begin
			if reg.stActual<10 then begin
				seek(archivo,filepos(archivo)-1);
				reg.precio:=reg.precio*0.15;
				write(archivo,reg);
				end;
			read(archivo,reg);
		end;
		close(archivo);
	end;


var
archivo:archivoProducto;
fileName:string;
opcion:byte;

BEGIN
	write('Ingrese nombre del archivo : ');readln(fileName);
	assign (archivo,fileName);	
	clrscr;
	writeln ('1) Crear archivo y cargar'); 
	writeln ('2) Lista productos por debajo del stock minimo'); 
	writeln ('3) Incremetar un 15% el valor de los productos con stock menor a 10 u');

	write (' Ingrese opcion: '); readln(opcion);
	writeln();
	case opcion of 
		1:crear_archivo (archivo);
		2:debajo_stock_minimo(archivo);
		3:incrementar_precio(archivo)
	end;
	
			

	
END.

