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
	while (NOT eof(archivo)) do begin
		read(archivo,num);
		writeln(num);
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
