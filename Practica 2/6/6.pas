program asd;
uses crt;
const valorAlto=9999;
type 
	votos=RECORD
		provincia:integer;
		localidad:integer;
		mesa:integer;
		cantidad:integer;
		end;
		
archivo=file of votos;


procedure importar(var a:archivo;var t:text);
	var 
		reg:votos;
	begin
		reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.provincia,reg.localidad,reg.mesa,reg.cantidad);
			write(a,reg);
		end;
		close(a);close(t);
	end;
	

procedure leer(var a:archivo;var reg:votos);
	begin
	if not eof (a) then read(a,reg) else reg.provincia:=valorAlto;
	end;


procedure listado(var a:archivo);
	var
		reg:votos;
		provincia,localidad,cant_prov,cant_loc,cant_tot:integer;
	begin
		reset(a);
		leer(a,reg);
		cant_tot:=0;
		
		while (reg.provincia<>valorAlto) do begin
		  provincia:=reg.provincia;
		  Writeln;
		  Writeln;
		  Writeln('||||||||||||||||||||||||||||||||||||||||');
		  Writeln;
		  Writeln('Codigo de Provincia: ',provincia);
		  Writeln;
		  cant_prov:=0;
		 
		  while ((reg.provincia=provincia) AND( reg.provincia<>valorAlto ))do begin
			localidad:=reg.localidad;
			cant_loc:=0;
			Write('Codigo de Localidad: ',localidad:8);
			
			while ( (reg.localidad=localidad) AND (reg.provincia=provincia) 
											AND (reg.provincia<>valorAlto)) do begin
				cant_loc:=cant_loc+reg.cantidad;
				leer(a,reg);
			end;
			
			Writeln(cant_loc:10);
			cant_prov:=cant_prov+cant_loc;
		  end;
		  Writeln;
		  Writeln('Total de Votos Provincia:  ',cant_prov);
		  cant_tot:=cant_tot+cant_prov;
		end;
		Writeln;
		Writeln('----------------------------------------');
		Writeln('Total general de votos: ',cant_tot);
		Writeln('________________________________________');
		close(a);
	end;

var
	fileName:string;
	t:text;
	a:archivo;
begin
	write('Nombre del archivo : ');readln(fileName);
	assign(t,fileName);
	assign(a,'votos.bin');
	importar(a,t);
	listado(a);
	
end.
