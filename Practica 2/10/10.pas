{Sin probar!! }
program diez;
uses crt;
const valorAlto='9999';
type 
	regMaestro=RECORD
		provincia:string[15];
		alfabetizados:integer;
		encuestados:integer;
		end;
	regDetalle=RECORD
		provincia:string[15];
		localidad:integer;
		alfabetizados:integer;
		encuestados:integer;
		end;
		
maestro=file of regMaestro;
detalle=file of regDetalle;

procedure leerM (var a:maestro;var reg:regMaestro);
	begin
		if not eof(a) then read(a,reg)
		else reg.provincia:=valorAlto;
	end;
	
procedure leerD (var a:detalle;var reg:regDetalle);
	begin
		if not eof(a) then read(a,reg)
		else reg.provincia:=valorAlto;
	end;

procedure importarMaestro(var a:maestro;var t:text);
	var 
		reg:regMaestro;
	begin
		reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.provincia,reg.alfabetizados,reg.encuestados);
			write(a,reg);
		end;
		close(a);close(t);
	end;
	
procedure importarDetalle(var a:detalle;var t:text);
	var 
		reg:regDetalle;
	begin
		reset(t);rewrite(a);
		while not eof(t) do begin
			readln(t,reg.provincia,reg.localidad,reg.alfabetizados,reg.encuestados);
			write(a,reg);
		end;
		close(a);close(t);
	end;
		
procedure minimo(var rdet1,rdet2,min:regDetalle; var adet1,adet2:detalle );
	begin
		if rdet1.provincia<=rdet2.provincia then begin
			min:=rdet1;
			leerD(adet1,rdet1);
			end
			else begin
				min:=rdet2;
				leerD(adet2,rdet2);
			end;
	end;
		
		
procedure actualizar_maestro(var mae:maestro;var det1,det2:detalle);
	var
	rdet1,rdet2,min:regDetalle;
	regMae:regMaestro;
	alfab,encues:integer;
	prov:string;
	begin
		reset(mae);reset(det1);reset(det2);
		leerM(mae,regMae);
		minimo(rdet1,rdet2,min,det1,det2);
		while min.provincia<>valorAlto do begin	 
			prov:=min.provincia;
			alfab:=0;
			encues:=0;
		
			while ((prov=min.provincia) AND (min.provincia<>valorAlto) ) do begin
				alfab:=alfab+rdet1.alfabetizados;
				encues:=encues+rdet1.encuestados;
				minimo(rdet1,rdet2,min,det1,det2);
			end;
			
			while regMae.provincia<>prov do begin
				leerM(mae,regMae);
			end;
			
			regMae.alfabetizados:=regMae.alfabetizados+alfab;
			regMae.encuestados:=regMae.encuestados+encues;
			seek(mae,filepos(mae)-1);
			write(mae,regMae);
	
		end;
		close(mae);close(det1);close(det2);
		
	end;

	
var
	opc:char;
	textMaestro,textDetalle1,textDetalle2:text;
	det1,det2:detalle;
	mae:maestro;
BEGIN
	Write ('Importar archivos maestro y detalles? S/N: ');readln(opc);
	assign(mae,'maestro.bin');assign(det1,'detalle1.bin');assign(det2,'detalle2.bin');
	if opc='S' then begin
		assign(textMaestro,'maestro.txt');
		assign(textDetalle1,'detalle1.txt');
		assign(textDetalle2,'detalle2.txt');
		importarMaestro(mae,textMaestro);
		importarDetalle(det1,textDetalle1);
		importarDetalle(det2,textDetalle2);
	end;
	actualizar_maestro(mae,det1,det2);
		
END.
