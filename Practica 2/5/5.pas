program as;
uses crt;
const valorAlto=9999;
type 

	informacion=RECORD
		cliente:integer;
		anio:integer;
		mes:integer;
		dia:integer;
		venta:integer;
	  end;
	  
archivo=file of informacion;

procedure importar(var a:archivo;var t:text);
	var 
		reg:informacion;
	begin
		reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.cliente,reg.anio,reg.mes,reg.dia,reg.venta);
			write(a,reg);
		end;
		close(a);close(t);
	end;
	
procedure leer(var a:archivo;var reg:informacion);
	begin
	if not eof (a) then read(a,reg) else reg.cliente:=valorAlto;
	end;
	
	
procedure reporte(var a:archivo);
	var
	reg:informacion;
	anio,mes,totMes,totAnio,tot:integer;
	begin
		clrscr;
		reset(a);
		leer(a,reg);
		while reg.cliente<>valorAlto do begin
			anio:=reg.anio;
			totAnio:=0;
			Writeln('Cliente : ',reg.cliente);
			
			while ( (reg.anio=anio) AND (reg.cliente<>valorAlto) ) do begin
				
				mes:=reg.mes;
				totMes:=0;
				
				while ((reg.mes=mes) AND (reg.anio=anio) AND (reg.cliente<>valorAlto) ) do begin
						totMes:=totMes+reg.venta;
						leer(a,reg);
				end;
				
				Writeln('Mes: ',mes,' total de ventas: ',totMes);
				totAnio:=totAnio+totMes;
		
		
			end;
			Writeln('Total en el año ',anio,' : ',totAnio);
			
		
		end;
		close(a);
	end;

var

a:archivo;
t:text;
opc:byte;
fileName:string;

begin 
repeat 	
	assign(a,'info.bin');
	Writeln('1)importar informacion desde un txt.');
	Writeln('2)Generar reporte');
	write('opcion=');
	readln(opc);
	case opc of
		1:begin
			write('nombre del txt: ');readln(fileName);
			assign (t,fileName);
			importar(a,t);
		   end;
		2:reporte(a);
		   
		  	
	end
until opc=0;

end.	  
