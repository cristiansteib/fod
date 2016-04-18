{
   2-2.pas
 Author=Cristian Steib
 * 
 * 
 * 
   el archivo alumnos.txt debe contener
    nombre
    apellido
    codigo materias_sin_final materias_con_final
   
   
   el archivo detalle.txt debe contener
	codigo materias_sin_final materias_con_final
   
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

procedure leer (var a:archivoDetalle;var r:alumnoD);
	begin
		if (not eof(a)) then read(a,r)
		else r.codigo:=valorAlto;
	end;


procedure importarMae(var bin:archivoMaestro; var txt:text);
	var reg:alumnoM;
	begin
		rewrite(bin); reset(txt);
		while (not eof(txt)) do begin
			readln(txt,reg.nombre);
			readln(txt,reg.apellido);
			readln(txt,reg.codigo,reg.materiasSinFinal, reg.materiasFinal);
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
			readln(txt,reg.codigo, reg.materia ,reg.conFinal);
			write(bin,reg);
		   end;
		close(bin);
		close(txt);
	end;

procedure exportarMae(var bin:archivoMaestro; var txt:text);
	var reg:alumnoM;
	begin
		reset(bin); rewrite(txt);
		while (not eof(bin)) do begin
			read(bin,reg);
			Writeln(txt,reg.nombre);
			Writeln(txt,reg.apellido);
			Writeln(txt,reg.codigo,' ',reg.materiasSinFinal,' ',reg.materiasFinal);
		   end;
		close(bin);
		close(txt);
	end;

procedure exportarDet(var bin:archivoDetalle; var txt:text);
	var reg:alumnoD;
	begin
		reset(bin); rewrite(txt);
		while (not eof(bin)) do begin
			read(bin,reg);
			writeln(txt,reg.codigo,' ', reg.materia,' ',reg.conFinal);
		   end;
		close(bin);
		close(txt);
	end;


procedure actualizar_maestro(var m:archivoMaestro ;var d:archivoDetalle );
	var
		regm:alumnoM;
		regd:alumnoD;
	begin
		clrscr;
		reset(m);reset(d);
		leer (d,regd);
		read(m,regm);
		while regd.codigo<>valorAlto do begin   // se procesan todos los datos del detalle
	
	
			while (regm.codigo<>regd.codigo ) do  // se recorre el maestro hasta encontrar el codigo
				read(m,regm);
			  			
			if regd.conFinal>0 then           // se realiza la actualizacion 
				regm.materiasFinal:=regm.materiasFinal+regd.conFinal
			else if regd.materia>0 then
				regm.materiasSinFinal:=regm.materiasSinFinal+regd.materia;
				
				
			seek(m,filepos(m)-1);  //
			write(m,regm);   	// se escriben los cambios
			leer(d,regd);   // se lee el siguiente registro del detalle
		end;					
		
		
	end;
	

procedure punto_f (var m:archivoMaestro;var t:text);
	var
		reg:alumnoM;
	begin
		reset(m);
		rewrite(t);
		while (not EOF (m)) do begin
			read(m,reg);
			if (reg.materiasSinFinal>=4) then
				writeln(t,reg.nombre,' ',reg.apellido,' ',reg.materiasSinFinal,' ',reg.materiasFinal);
		end;
		close(m);
		close(t);
	end;


var
	opcion:byte;
	mae:archivoMaestro;
	det:archivoDetalle;
	detTxt,	maeTxt, aTexto:text;
	txtReporteAlum,txtReporteDet:text;
	fileName:string;
BEGIN
	assign(mae,'maestro.bin');
	assign(det,'detalle.bin');
	assign(maeTxt,'alumnos.txt');
	assign(detTxt,'detalle.txt');
	assign(txtReporteAlum,'reporteAlumnos.txt');
	assign(txtReporteDet,'reporteDetalle.txt');
	
	repeat
		writeln ('Menu: ');
		writeln('1) Crear Maestro a partir de alumnos.txt');
		writeln('2) Crear Detalle a partir de detalle.txt');
		writeln('3) Crear reporte del archivo maestro a reporteAlumnos.txt');
		writeln('4) Crear reporte del archivo detalle a reporteDetalle.txt');
		writeln('5) Actualizar maestro.');
		writeln('6) Informar alumnos con mas de 4 materias sin final.');
		writeln('0) SALIR');
		Writeln;
		write('Ingrese N° de opcion: ');readln(opcion);
		case opcion of
			1:importarMae(mae,maeTxt);
			2:importarDet(det,detTxt);
			3:exportarMae(mae,txtReporteAlum);
			4:exportarDet(det,txtReporteDet);
			5:actualizar_maestro(mae,det);
			6:begin
				Writeln;
				Write('Ingrese el nombre del archivo a generar');readln(fileName);
				assign(aTexto,fileName+'.txt');
				punto_f (mae,aTexto);
			  end;
		 end;
		clrscr; 
	until opcion=0;
	
END.

