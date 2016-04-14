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
		rewrite (archivo);
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
		read(archivo,reg);
		write('Listar personas del mes: '); readln(mes);
		while (NOT eof(archivo)) do begin
			if (((reg.fecha MOD 10000) DIV 100) = mes) then
				write('CUMPLE CON MES : ')
				else if (reg.fecha = 0 ) then 
					write (' NO POSEE FECHA : ');
			mostrar_reg(reg);
			read(archivo,reg);
		end;
		close(archivo);
	end;

procedure agregar_datos(var archivo:archivoPersonas);
	var
		reg:personas;
	begin
		reset(archivo);
		cargar_reg(reg);
		seek(archivo,filesize(archivo));
		while reg.nombre<>'' do begin
			write (archivo,reg);
			cargar_reg(reg);
		end;
		close(archivo);
	end;
	
	
procedure modificar_fecha(var archivo:archivoPersonas);
	var
		reg:personas;
		nombre:string;
		apellido:string;
		salir:char;
	begin
		reset(archivo);
		salir:='s';
		while salir='s' do begin
			write('Buscar nombre: ');readln (nombre);
			write('Buscar apellido: ');readln (apellido);
			read(archivo,reg);
			while ((NOT eof (archivo))AND (reg.nombre<>nombre)AND (reg.apellido<>apellido)) do begin
				read(archivo,reg);
			end;
			if nombre=reg.nombre then begin
				write('Ingrese la fecha: ');readln(reg.fecha);
				seek(archivo,filepos(archivo)-1);
				write(archivo,reg);
			end else writeln('No se ha encontrado el nombre');
		writeln('Quiere cambiar otra fecha? s/n');read (salir);
		end;
		close (archivo);
	end;
			
procedure exportar (var archivo:archivoPersonas;var archivoTxt:text);
			var 
				reg:personas;
			begin	
				reset(archivo);
				rewrite(archivoTxt);
				while (NOT eof(archivo)) do begin
					read(archivo,reg);
					writeln(archivoTxt, reg.nombre);
					writeln(archivoTxt, reg.apellido);
					writeln(archivoTxt, reg.fecha);
				end;
				close(archivo);
				close(archivoTxt);	
			end;
		
		


var
archivo:archivoPersonas;
archivoTxt:text;
fileName:string;
opcion:byte;


BEGIN
	clrscr;
	writeln ('1) Crear archivo,y cargar datos'); 
	writeln ('2) Abrir archivo genereado'); 
	writeln ('3) Agregar datos');
	writeln ('4) Modificar fecha');
	writeln ('5) Exportar a personas.txt');
	write (' Ingrese opcion: '); readln(opcion);
	writeln();
	write('Ingrese nombre del archivo: ');readln(fileName);
	assign (archivo,fileName);
	assign (archivoTxt,'personas.txt');
	clrscr;
	case opcion of 
		1:cargar_archivo(archivo);
		2:listar_datos(archivo);
		3:agregar_datos(archivo);
		4:modificar_fecha(archivo);
		5:exportar(archivo,archivoTxt);
			
	end;

END.

