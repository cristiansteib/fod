{sin terminar.}

program once;
uses crt;
const valorAlto=9999;
type 
	registro=RECORD 
		facultad:integer;
		carrera:integer;
		anio_cursada:byte;
		voto:byte;
	end;
	
archivo=file of registro;
votos = array [1..5] of integer;


procedure leer(var a:archivo;r:registro);
	begin
		if not eof(a) then read (a,r) 
		else r.facultad:=valorAlto;
	end;
	
procedure inicializar_votos(var arr:votos);
	var 
		i:integer;
	begin
		for i:=0 to 5 do arr[i]:=0;
	end;
	
	

procedure informar(var a:archivo);
	var
		reg:registro;
		facultad,carrera:integer;
		voto:votos;
	begin
		reset (a);
		inicializar_votos(voto);
		leer(a,reg);
		while reg.facultad<>valorAlto do begin
			facultad:=reg.facultad ;
			Writeln;
			writeln('||||||||||||||||||||||||||||||||||||||||||||||||||');
			Writeln ('Facultad: ',facultad);
			while (reg.facultad=facultad) do begin
				carrera:=reg.carrera;
				Writeln('Carrera',carrera);
				while ( (carrera=reg.carrera) AND (reg.facultad=facultad)) do begin
				
				
				end;
				
			
			
			
			end;
		end;
		
	end;


var
a:archivo;
begin


end.
