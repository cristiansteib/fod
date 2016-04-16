{
   2-1.pas
 Author=Cristian Steib
 COMPILA,PERO NO LO PROBE! 
 
   
}


program untitled;
uses crt;
const valorAlto=9999;

type 
	ventas=RECORD
		codigo:integer; //codigo de promotor
		nombre:string[15];
		monto:real;
		end;
		
archivoDetalle = file of ventas;
archivoMaestro = file of ventas;

procedure leer (var a:archivoDetalle;var r:ventas);
	begin
		if (not eof(a)) then read(a,r)
		else r.codigo:=valorAlto;
	end;

var
	maestro:archivoMaestro;
	detalle:archivoDetalle;
	fileName:string;
	regM,regD:ventas;
	codigo:integer;
	montoT:real;
BEGIN
	writeln ('ingrese nombre del archivo detalle de ventas: ');readln(fileName);
	assign (detalle,fileName);
	assign (maestro,'maestro.bin');
	reset(detalle);
	rewrite(maestro);
	leer(detalle,regD);
	while (regD.codigo<>valorAlto) do begin
		codigo:=regD.codigo;
		montoT:=0;
		while (codigo = regD.codigo) do begin
			montoT:=montoT+regD.monto;
			leer(detalle,regD);
		  end;
		 regM.codigo:=codigo;
		 regM.monto:=montoT;
		 write(maestro,regM);
	end;
	close(detalle);
	close(maestro);		
END.

