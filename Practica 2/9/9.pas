program nueve;
uses crt;
const valorAlto=999;
type 
	empleado=RECORD
		departamento:integer;
		division:integer;
		numero_empleado:integer;
		categoria:integer;
		cantidad_horas:integer;
	   end;
	   
valor_de_hora=array [1..15] of real;


procedure cargar_arreglo(var arreglo:valor_de_hora;var t:text);
	var
		i:integer;
		valor:real;
	begin
		reset(t);
		for i:=1 to 15 do begin
			readln(t,valor);
			arreglo[i]:=valor;
		end;
		close(t);
	end;
	

var
	fileName:string;
	arch_arreglo:text;
	arreglo:valor_de_hora;
begin
	Write('Nombre del archivo array: ');readln(fileName);
	assign(arch_arreglo,fileName);
	cargar_arreglo(arreglo,arch_arreglo);

end.
