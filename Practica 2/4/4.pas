program ejer4;
uses crt;
const valorAlto=9999;


type
	producto=RECORD
		codigo:integer;
		nombre:string[30];
		precio:real;
		stockAct:integer;
		stockMin:integer;
      end;
     
    venta=RECORD
		codigo:integer;
		cantidad:integer;
	  end;
	  
detalle= file of venta;
maestro= file of producto;



procedure leer (var archivo:detalle; var registro:venta);   //leer para el detalle
begin
	if not EOF(archivo) then
		read(archivo,registro)
	else registro.codigo:=valorAlto;
end;


procedure importarMaestro(var a:maestro; var t:text );
	var
		regM:producto;
	begin
	
		reset(t);
		rewrite(a);
		with regM do begin
			while (NOT EOF(t)) do begin
				readln(t,codigo,precio,stockAct,stockMin,nombre);
				write(a,regM);
			  end;
		  end;
		close (t);
		close (a);
	end;  

procedure importarDetalle(var a:detalle; var t:text );
	var
		regD:venta;
	begin
		reset(t);
		rewrite(a);
		with regD do begin
			while (NOT EOF(t)) do begin
				readln(t,codigo,cantidad);
				write(a,regD);
			  end;
		  end;
		close (t);
		close (a);
	end;  
		
	
		
procedure exportarMaestro(var a:maestro; var t:text );
	var
		regM:producto;
	begin
		reset(a);
		rewrite(t);
		with regM do begin
			while NOT EOF(a) do begin
				read(a,regM);
				writeln(t,codigo,' ',precio:0:2,' ',stockAct,' ',stockMin,' ',nombre);
			end;
		end;	
		close(a);
		close(t);
	end;	



procedure recorrer (var a:detalle);
var regD:venta;
	begin
		clrscr;
		reset(a);
		while not EOF(a) do begin
			read(a,regD);
			writeln(regD.codigo:10,regD.cantidad:10);
		end;
		close(a);
		readkey;
	end;		
		
		
procedure actualizar(var m:maestro; var d:detalle);
var
	regD:venta;
	regM:producto;
	begin
		reset(m);
		reset(d);
		read(m,regM);
		leer(d,regD);
		while (regD.codigo <> valorAlto) do begin
			
			
			while regM.codigo<>regD.codigo do
				read(m,regM);
		
			while (regM.codigo=regD.codigo) do begin
				regM.stockAct:=regM.stockAct - regD.cantidad;   //stockAct puede quedar negativo?
				leer(d,regD);	
			end;
			
			seek(m,filepos(m)-1);
			write(m,regM);
			
			if not eof(m)then read(m,regM);
		end;
		close(m);
		close(d);
	end;



procedure reportar (var arch:maestro; var rep:text);
var
	regM:producto;
begin
	reset(arch);
	rewrite(rep);
	while not EOF(arch) do begin
		read(arch,regM);
		if(regM.stockAct < regM.stockMin) then	writeln(rep,regM.codigo,' ',regM.precio:0:2,' ',regM.stockAct,' ',regM.stockMin,' ',regM.nombre);
	end;
	close(arch);
	close(rep);
end;		

		
var
mae:maestro;
det:detalle;
productos,reporte,reporteStock,ventas:text;
opc:byte;
BEGIN
	assign(productos,'productos.txt');
	assign(reporte,'reporte.txt');
	assign(ventas,'ventas.txt');
	assign(mae,'maestro.bin');
	assign(det,'detalle.bin'); 
	assign (reporteStock,'stockMinimo.txt');
	repeat
		clrscr;
		Writeln('Menu:');
		Writeln('1)Importar maestro desde productos.txt');
		Writeln('2)Exportar maestro a reporte.txt');
		Writeln('3)Importar detalle desde ventas.txt');
		Writeln('4)Recorrer');
		Writeln('5)Actualizar maestro con detalle');
		
		Writeln('6)Generar reporte en archivo stockminimo.txt');
		Writeln('0)EXIT');
		Writeln;
		Write('Ingrese opcion:');readln(opc);
		case opc of 
			1:importarMaestro(mae,productos);
			2:exportarMaestro(mae,reporte);
			3:importarDetalle(det,ventas);
			4:recorrer(det);
			5:actualizar(mae,det);
			6:reportar(mae,reporteStock);
		end;
	until opc=0;
	
	

END.
