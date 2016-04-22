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
archivo=file of empleado;


procedure importar(var a:archivo;var t:text);
	var 
		reg:empleado;
	begin
		reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.departamento,reg.division,reg.numero_empleado,reg.categoria,reg.cantidad_horas);
			write(a,reg);
		end;
		close(a);close(t);
	end;
	


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
	
	
procedure leer(var a:archivo;var reg:empleado);
	begin
		if not eof(a) then read(a,reg)
		else reg.departamento:=valorAlto;
	end;
	
	
procedure listar(var a:archivo;var arreglo:valor_de_hora);
	var
		reg:empleado;
		division,totHorasDivision:integer;
		totMontoDivision,totMontoDepartamento:real;
		departamento,totHorasDepartamento:integer;
		importe:real;
	begin
		reset(a);
		leer(a,reg);
		while reg.departamento<> valorAlto do begin // se recorre todo el archivo
			departamento:=reg.departamento;
			totHorasDepartamento:=0;
			totMontoDepartamento:=0;
			Writeln('------------------------------------------------------------------------------');
			Writeln('DEPARTAMENTO ',departamento);
			while ( (departamento=reg.departamento) AND (reg.departamento<>valorAlto) ) do begin
				division:=reg.division;
				totHorasDivision:=0;
				totMontoDivision:=0;
				Writeln;
				Writeln('Division ',division);
				
				while ( (reg.division = division) AND (departamento=reg.departamento) AND (reg.departamento<>valorAlto) )  do begin
					importe:=reg.cantidad_horas*arreglo[reg.categoria];
					Writeln('Empleado: ',reg.numero_empleado:10,'      Total de horas: ',reg.cantidad_horas:6,'     Importe a cobrar: ',importe:2:2);
					totHorasDivision:=totHorasDivision+reg.cantidad_horas;
					totMontoDivision:=totMontoDivision+importe;
					leer(a,reg);
				end;
				Writeln('Total de horas division: ',totHorasDivision);
				writeln('Monto total por division: ',totMontoDivision:2:2);
				totHorasDepartamento:=totHorasDepartamento+totHorasDivision;
				totMontoDepartamento:=totMontoDepartamento+totMontoDivision;
			end;
			Writeln;
			writeln;
			Writeln('------------------------------------------------------------------------------');
			writeln('______________________________________________________________________________');
			Writeln('Total horas departamento: ',totHorasDepartamento);
			Writeln('Monto total departamento: ',totMontoDepartamento:2:2);
			Writeln('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
			writeln;
			writeln;
		end;
		close(a);
		
	end;
	
	

var
	fileName:string;
	arch_arreglo,text_arch_empleado:text;
	arch_empleado:archivo;
	arreglo:valor_de_hora;
begin
	Write('Nombre del archivo array txt: ');readln(fileName);
	assign(arch_arreglo,fileName);
	cargar_arreglo(arreglo,arch_arreglo);
	
	Write('Nombre del archivo empleado txt: ');readln(fileName);
	assign(text_arch_empleado,fileName);
	assign(arch_empleado,'empleados.bin');
	importar(arch_empleado,text_arch_empleado);
	listar(arch_empleado,arreglo);
	
	
	

end.
