program doce;
uses crt;
const valorAlto=999;
type 
	censo=RECORD 
		continente:integer;
		pais:string[15];
		ciudad:string[15];
		cant_varones:integer;
		cant_mujeres:integer;
	end;
	
archivo=file of censo;

procedure importar(var a:archivo;var t:text);
	var
		reg:censo;
	begin
		reset (t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.continente,reg.cant_varones,reg.pais);
			readln(t,reg.cant_mujeres,reg.ciudad);
			write(a,reg);
		end;	
		close(a);close(t);
	end;

procedure leer(var a:archivo; var r:censo);
	begin
	if not eof (a) then read(a,r)
	else r.continente:=valorAlto;
	end;

procedure informar(var a:archivo;var informe:text);
	var
	reg:censo;
	pais:string;
	continente,tot_pais,tot_continente:integer;
	begin
	reset(a);rewrite(informe);
	leer(a,reg);
	
	while reg.continente<>valorAlto do begin
		continente:=reg.continente;
		tot_continente:=0;
		writeln(informe,'Continente: ',continente);
		while continente=reg.continente do begin
			pais:=reg.pais;
			tot_pais:=0;
			writeln(informe,'Pais: ',pais);
			while ( (continente=reg.continente) AND (pais=reg.pais) ) do begin
				Write(informe,'Ciudad:',reg.ciudad);
				Write(informe,'  Cantidad de varones:',reg.cant_varones);
				Write(informe,'  Cantidad de mujeres:',reg.cant_mujeres);	
				Write(informe,'  Cantidad de habitantes:',reg.cant_varones+reg.cant_mujeres);
				writeln(informe);
				leer(a,reg);
				tot_pais:=tot_pais+(reg.cant_varones+reg.cant_mujeres);
			end;
			Writeln(informe,'');
			Writeln(informe,'Total de habitantes pais: ':tot_pais);
			tot_continente:=tot_continente+tot_pais;
		end;
		Writeln(informe,'');
		Writeln(informe,'Total habitantes continente: ',tot_continente);	
	end;
	end;

var
t_informe,t:text;
a:archivo;


begin
	assign (t,'censo.txt');
	assign(a,'censo.bin'); 
	assign(t_informe,'informe.txt');
	importar(a,t);
	informar(a,t_informe);
	end.
