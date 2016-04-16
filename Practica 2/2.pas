{
   2-1.pas
 Author=Cristian Steib
   
}


program untitled;
uses crt;
const valorAlto=9999;

type 
	alumnoM=RECORD
		codigo:integer; //codigo de alumno
		nombre:string[15];
		apellido:string[15];
		materiasFinal:integer;
		materiasSinFinal:integer;
	   end;
		
	alumnoD=RECORD
		codigo:integer;
		materia:byte;
		conFinal:byte;
	   end;
		
archivoDetalle = file of alumnoD;
archivoMaestro = file of alumnoM;
{
procedure leer (var a:archivoDetalle;var r:ventas);
	begin
		if (not eof(a)) then read(a,r)
		else r.codigo:=valorAlto;
	end;
}

procedure importarMae(var bin:archivoMaestro; var txt:text);
	var reg:alumnoM;
	begin
		rewrite(bin); reset(txt);
		while (not eof(txt)) do begin
			readln(txt,reg.codigo);
			readln(txt,reg.nombre);
			readln(txt,reg.apellido);
			readln(txt,reg.materiasFinal);
			readln(txt,reg.materiasSinFinal);
			write(bin,reg);
		   end;
		close(bin);
		close(txt);
	end;

procedure importarDet(var bin:archivoDetalle; var txt:text);
	var reg:alumnoD;
	begin
		rewrite(bin); reset(txt);
		while (not eof(txt)) do begin
			readln(txt,reg.codigo);
			readln(txt,reg.materia);
			readln(txt,reg.conFinal);
			write(bin,reg);
		   end;
		close(bin);
		close(txt);
	end;



var
	opcion:byte;
	mae:archivoMaestro;
	det:archivoDetalle;
	detTxt:text;
	maeTxt:text;
BEGIN
	opcion:=99;
	assign(mae,'maestro.bin');
	assign(det,'detalle.bin');
	assign(maeTxt,'alumnos.txt');
	assign(detTxt,'detalle.txt');
	while opcion<>0 do begin
		writeln ('Menu: ');
		writeln('1) Crear Maestro a partir de alumnos.txt');
		writeln('2) Crear Detalle a partir de detalle.txt');
		writeln('3) Crear reporte del archivo maestro a reporteAlumnos.txt');
		writeln('4) Crear reporte del archivo maestro a reporteAlumnos.txt');
		write('Ingrese N de opcion: ');readln(opcion);
		case opcion of
			1:importarMae(mae,maeTxt);
			2:importarDet(det,detTxt);
		 end;
		clrscr; 
	end;
	
END.

