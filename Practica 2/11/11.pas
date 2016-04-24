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

procedure importar(var a:archivo;var t:text);
	var 
		reg:registro;
	begin
		reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.facultad,reg.carrera,reg.anio_cursada,reg.voto);
			write(a,reg);
		end;
		close(a);close(t);
	end;




procedure leer(var a:archivo;var r:registro);
	begin
		if (not eof(a))
			then read (a,r) 
		else 
			r.facultad:=valorAlto;
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
		facultad,carrera,i:integer;
		anio:byte;
		votos_x_anio,votos_totales_carrera,votos_totales_facultad:votos;

	begin
		reset (a);
		inicializar_votos(votos_x_anio);
		inicializar_votos(votos_totales_carrera);
		inicializar_votos(votos_totales_facultad);
		leer(a,reg);
		writeln(reg.facultad);
		while reg.facultad<>valorAlto do begin
			
			facultad:=reg.facultad ;
			Writeln;
			writeln('_______________________________________________________________');
			Writeln ('Facultad: ',facultad);
			while (reg.facultad=facultad) do begin
				carrera:=reg.carrera;
				Writeln('Carrera ',carrera);
				Writeln('______________________________________________________________');
				Writeln('                Agrup1 | Agrup2 | Agrup3 | Agrup4 | Agrup5 |');
				while ( (carrera=reg.carrera) AND (reg.facultad=facultad)) do begin
					
					anio:=reg.anio_cursada;
					Write(anio,'año      ');
					
					while ( (anio=reg.anio_cursada) AND (carrera=reg.carrera) AND (reg.facultad=facultad)) do begin
							votos_x_anio[reg.voto]:=votos_x_anio[reg.voto]+1;
							leer(a,reg);
					end;
					
					for i:=1 to 5 do begin
						write(votos_x_anio[i]:9);   // muestro los votos de ese año
						votos_totales_carrera[i]:=votos_totales_carrera[i]+votos_x_anio[i]; //se actualizan los votos totales de la carrera
					end;
					Writeln;
					inicializar_votos(votos_x_anio);
				end;
				Writeln;
				Writeln('Total carrera:');
			    Write('          ');
				for i:=1 to 5 do begin
						write(votos_totales_carrera[i]:9);   // muestro los votos de la carrera
						votos_totales_facultad[i]:=votos_totales_facultad[i]+votos_totales_carrera[i]; //se actualizan los votos totales de la facultad
				end;
				writeln;
				inicializar_votos(votos_totales_carrera);	
			end;
			Writeln('Total facultad:');
			Write('          ');
			for i:=1 to 5 do  write(votos_totales_facultad[i]:9);   // muestro los votos de la facultad
			inicializar_votos(votos_totales_facultad);				
			
		end;
		close(a);
	end;


var
a:archivo;
t:text;
begin
assign(t,'votos.txt');
assign(a,'votos.bin');
importar(a,t);
informar(a);



end.
