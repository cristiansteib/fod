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
	num,par,impar:integer;
begin
	reset(archivo);
	par:=0; impar:=0;
	read(archivo,num);
	while (NOT eof(archivo)) do begin
		if (num MOD 2 = 0 ) then par:=par+1 else impar:=impar+1;
		read(archivo,num);
	end;
	writeln('Cantidad de numeros pares: ',par);
	writeln('Cantidad de numeros impares: ',impar);
	close(archivo);
end;

var fileName:string;
archivo:archivoNumeros;
numero:integer;


BEGIN
	clrscr;
	write('Ingrese nombre de archivo: '); readln(fileName);
	assign(archivo,fileName);
	recorrer(archivo);
END.

