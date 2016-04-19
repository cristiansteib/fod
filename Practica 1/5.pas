{
* Author= Cristian Steib
* 
* }
program untitled;

uses crt;
type 
	personas=record
		apellido:string;
		nombre:string;
		fecha:LongInt;
		end;
	


archivoPersonas= file of personas;

procedure cargar_reg(var reg:personas);
	begin
		with reg do begin
			write('ingrese apellido : ');readln(apellido);
			write('ingrese nombre : ');readln(nombre);
			write('ingrese fecha aaaammdd : ');readln(fecha);
			writeln();
		end;
	end;


procedure cargar_archivo(var archivo:archivoPersonas);
	var
		reg:personas;
	begin
		reset (archivo);
		cargar_reg(reg);
		while reg.apellido <> '' do begin
			write(archivo,reg);
			cargar_reg(reg);
		end;
		close(archivo);
	end;


procedure mostrar_reg(var reg:personas);
	begin
		with reg do begin
			writeln(nombre:20,apellido:10,fecha:10);
		end;
	end; 


procedure listar_datos(var archivo:archivoPersonas);
	var 
		reg:personas;
		mes:integer;
	begin
		reset(archivo);
		write('Listar personas del mes: '); readln(mes);
		while (NOT eof(archivo)) do begin
			read(archivo,reg);
			if (((reg.fecha MOD 10000) DIV 100) = mes) then
				write('CUMPLE CON MES : ')
				else if (reg.fecha = 0 ) then 
					write (' NO POSEE FECHA : ');
			mostrar_reg(reg);
		end;
		close(archivo);
	end;



var
archivo:archivoPersonas;
fileName:string;
opcion:byte;


BEGIN
	clrscr;
	writeln ('1) Crear archivo,y cargar datos'); 
	writeln ('2) Abrir archivo genereado'); 
	write (' Ingrese opcion: '); readln(opcion);
	writeln();
	write('Ingrese nombre del archivo: ');readln(fileName);
	assign (archivo,fileName);
	clrscr;
	case opcion of 
		1:begin
			rewrite(archivo);
			cargar_archivo(archivo);
			end;
		2:begin
			reset(archivo);
			listar_datos(archivo);
			end;
			
	end;

END.

