//
// EJERCICIO SIN PROBAR! 
//

program trece;
uses crt;
const valorAlto=9999;
type
	rMaestro=RECORD 
		destino:integer;
		fecha:longint;
		hora:longint;
		asientos:byte;
		end;
	rDetalle=RECORD
		destino:integer;
		fecha:longint;
		hora:longint;
		asientos_comprados:byte;
		end;
	
maestro=file of rMaestro;
detalle=file of rDetalle;

procedure leer (var a:detalle;var r1:rDetalle);
	begin
		if not eof(a) then read(a,r1)
		else r1.destino:=valorAlto;
	end;

procedure minimo(var a1,a2:detalle; var r1,r2,min:rDetalle);
	begin
		if (r1.destino<=r2.destino) then begin
			min:=r1;
			leer(a1,r1);
		end
		else begin
			min:=r2;
			leer(a2,r2);
			end;
	end;
			
procedure actualizar_maestro(var mae:maestro;var det1,det2:detalle);
		{
		* Proceso sin probar!! 
		* }
		
		var
			destino:integer;
			fecha,hora:longint;
			rMae:rMaestro;
			min,rdet1,rdet2:rDetalle;
			asientos_usados:byte;
		begin
			reset(mae);reset(det1);reset(det2);
			minimo(det1,det2,rdet1,rdet2,min);
			read(mae,rMae);
			
			while min.destino<>valorAlto do begin
				destino:=min.destino;
				
				while destino=min.destino do begin
					fecha:=min.fecha;
					hora:=min.hora;
					asientos_usados:=0;
					
					while( (fecha=min.fecha) AND (hora=min.hora) AND (destino=min.destino))do begin
						asientos_usados:=asientos_usados+min.asientos_comprados;
						minimo(det1,det2,rdet1,rdet2,min);
					end;
					
					while( (rMae.destino<>destino) and (rMae.hora<>hora) and (rMae.fecha<>fecha )) do
						read(mae,rMae);  //leo hasta encontrar el registro indicado,NO CONTROLO FIN YA QUE DEBE EXISTIR EL REGISTRO
					
					rMae.asientos:=rMae.asientos-asientos_usados;
					seek(mae,filepos(mae)-1);
					write(mae,rMae);
				
				end;
			
			end;
			
			close(mae);
		end;
	
	
	
procedure listar(var mae:maestro);
		var
		cantidad:byte;
		rMae:rMaestro;
		begin
			reset(mae);
			write('Listar vuelos con capacidad menor a:');readln(cantidad);
			while not eof(mae) do begin
				read(mae,rMae);
				if rMae.asientos<cantidad then begin
					writeln('Vuelo:',rMae.destino);
					Writeln('fecha: ',rMae.fecha);
					writeln('hora: ',rMae.hora);
					Writeln('capacidad: ',rMae.asientos);
					Writeln('--------------');
				end;
			end;
			
			
		end;
	
var
det1,det2:detalle;
mae:maestro;
begin

assign (det1,'detalle1.bin');
assign (det2,'detalle2.bin');
assign (mae,'maestro.bin');
actualizar_maestro(mae,det1,det2);
listar(mae);

end.
