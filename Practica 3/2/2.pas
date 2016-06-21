{
* Author= Cristian Steib
* 
* }
program untitled;
uses crt;

const valorAlto='zzz';
type 
	personas=record
		apellido:string;
		nombre:string;
		fecha:LongInt;
		end;
		
archivoPersonas= file of personas;


procedure leer (var a:archivoPersonas;var reg:personas);
	begin
		if not eof(a) then read(a,reg) 
		else reg.nombre := valorAlto;
	end;
	
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


procedure listar_datos_mes(var archivo:archivoPersonas);
	var 
		reg:personas;
		mes:integer;
	begin
		reset(archivo);
		write('Listar personas del mes: '); readln(mes);
		leer (archivo,reg);
		while reg.nombre<>valorAlto do begin
			if (((reg.fecha MOD 10000) DIV 100) =  mes ) then
				mostrar_reg(reg);
			leer(archivo,reg);
		end;
		close(archivo);
	end;


procedure listar_personas(var a:archivoPersonas);
	var 
		reg:personas;
	begin
		reset(a);
		leer(a,reg);
		while reg.nombre<>valorAlto do 
			begin
				mostrar_reg(reg);
				leer(a,reg);
			end;
		close(a);
	end;

procedure baja (var archivo:archivoPersonas);
	var
		name,lastname:string;
		reg:personas;
		pos:integer;
	begin
		reset (archivo);
		writeln('BAJA DE UNA PERSONA');
		write('ingrese nombre: ');
		readln(name);
		write('ingrese apellido: ');
		readln(lastname);
		leer (archivo,reg);
		while (reg.nombre <>valorAlto) and (reg.nombre<>name) do 
			leer(archivo,reg);
		if (reg.nombre=name) then
			begin
				while (reg.nombre = name) and (reg.apellido<>lastname) do 
					leer(archivo,reg);					
			  if (reg.nombre=name) and (reg.apellido=lastname) then //founded
					begin
						writeln ('encontrado');
						pos:=filepos(archivo)-1;
						seek(archivo,filesize(archivo)-1);
						read(archivo,reg);
						seek(archivo,pos);
						write(archivo,reg);
						seek(archivo,filesize(archivo)-1);
						truncate(archivo);
					end
				else
						close(archivo);				
			end
			else
				close (archivo);
	end;




var
archivo:archivoPersonas;
fileName:string;
opcion:byte;


BEGIN
	write('Ingrese nombre del archivo: ');readln(fileName);
	assign (archivo,fileName);
	repeat
	clrscr;
	writeln ('1) Crear archivo,y cargar datos.'); 
	writeln ('2) Listar Datos segun mes.'); 
	writeln ('3) Baja de persona.');
	writeln ('4) Listar personas.');
	write (' Ingrese opcion: '); readln(opcion);
	writeln();

	clrscr;
	case opcion of 
		1:begin
			cargar_archivo(archivo);
			end;
		2:begin
			reset(archivo);
			listar_datos_mes(archivo);
			end;
		3:begin
			baja(archivo);
			end;
		4:begin
			listar_personas(archivo);
			end;
			
	end;
	readkey;
	until opcion=0;

END.
