{
   7.pas
Author= Cristian Steib
   
   
}


program untitled;

uses crt;
type 
	medicamentos= record
		nombre:string;
		presentacion:string;
		vencimiento:Longint;
		stock:integer;
		end;


archivoMedicamentos = file of medicamentos;


procedure importar (var bin:archivoMedicamentos;var txt:text);
	var 
		reg:medicamentos;
	begin
		rewrite(bin);
		reset(txt);
		while (not eof(txt)) do begin
			readln(txt, reg.nombre);
			readln(txt, reg.vencimiento, reg.stock, reg.presentacion);
			write(bin,reg);
		end;
		close(bin);
		close(txt);
	end;
	
	
procedure exportar (var bin:archivoMedicamentos;var txt:text);
			var 
				reg:medicamentos;
			begin	
				reset(bin);
				rewrite(txt);
				while (NOT eof(bin)) do begin
					read(bin,reg);
					writeln(txt, reg.nombre);
					writeln(txt, reg.vencimiento,reg.stock,reg.presentacion)
				end;
				close(bin);
				close(txt);	
			end;
	
procedure listar(var a:archivoMedicamentos);
	{
	* Se listaran los que tengan stock menor a 20
	* }
	var
	reg:medicamentos;
	begin
		reset(a);
		while(not eof(a)) do begin
			read(a,reg);
			if reg.stock<20 then writeln(reg.nombre);
		end;
		close(a);
	end;
	
function coincide_palabra (palabra1:string;palabra2:string):boolean;
	var
		p2:string;
		i:integer;
begin
	p2:='';
	if Length(palabra1)<Length(palabra2) then begin
		for i:=1 to Length(palabra1) do begin
			p2:=p2+palabra2[i];
		end;
		if palabra1=p2 then coincide_palabra:=true else coincide_palabra:=false;
	end
	else if Length(palabra1)=Length(palabra2) then begin
		if palabra1=palabra2 then coincide_palabra:=true else coincide_palabra:=false;
	end;

end;	
	
procedure buscar_listar(var a:archivoMedicamentos);
	{
	*  VERIFICAR SI ES LO QUE SE PIDE 
	* 
	* }
	var
	nombre:string;
	reg:medicamentos;
	begin
		reset(a);
		write('Ingrese comienzo de cadena a buscar: ');readln(nombre);
		while(not eof(a)) do begin
			read(a,reg);
			if coincide_palabra(nombre,reg.nombre) then 
				writeln(reg.nombre);
		end;
	end;
			
			


var
aBinario:archivoMedicamentos;
aCarga:text;
aMedicamentos:text;
fileName:string;
opcion:byte;

BEGIN
	write('Ingrese nombre del archivo binario: ');readln(fileName);
	assign (aBinario,fileName);	
	assign (aCarga,'Carga.txt');
	assign (aMedicamentos,'Medicamentos.txt');
	clrscr;
	opcion:=99;
	while opcion<> 0 do begin
		writeln ('1) Crear archivo binario desde carga.txt'); 
		writeln ('2) Listar medicamentos con stock menor a 20'); 
		writeln ('3) Buscar medicamentos que inicien con cierta palabra'); 
		writeln ('4) Exportar archivo binario medicamentos a medicamentos.txt'); 
		writeln ('0) SALIR '); 
		Writeln;
		write (' Ingrese opcion: '); readln(opcion);
		case opcion of 
			1:importar (aBinario,aCarga);
			2:listar(aBinario);
			3:buscar_listar(aBinario);
			4:exportar (aBinario,aMedicamentos);
		end;
		clrscr;
	end;
	
			

	
END.

