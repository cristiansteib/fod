{
* Author= Cristian Steib
* 
* }
program untitled;

uses crt;
type 

archivoNumeros= file of integer;

procedure recorrer(var archivo:archivoNumeros);
var
	num:integer;
begin
	reset(archivo);
	read(archivo,num);
	while (NOT eof(archivo)) do begin
		writeln(num);
		read(archivo,num);
	end;
	close(archivo);
end;

var fileName:string;
archivo:archivoNumeros;

BEGIN
	clrscr;
	write('Ingrese nombre de archivo: '); readln(fileName);
	assign(archivo,fileName);
	recorrer(archivo);
END.
