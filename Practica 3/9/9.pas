program 9;
uses crt;

type
	medicamento=RECORD
		nombre:string;
		descripcion:string;
		stock:integer;
		end;

archivo=file;


procedure crear(var a:archivo);
	var
	 reg:medicamento;
	 campo,registro:char;
	begin
		campo:='@';
		registro:='#';
		rewrite(a,1);
		Write('Ingrese nombre: ');readln(reg.nombre);
		repeat
			Write('Descripcion: ');readln(reg.descripcion);
			Write('Stock: ');readln(reg.stock);
			writeln;
			
			blockWrite(a,reg.nombre,Length(reg.nombre)+1);
			blockWrite(a,campo,1);
			blockWrite(a,reg.descripcion,Length(reg.descripcion)+1); 
			blockWrite(a,campo,1);
			blockWrite(a,reg.stock,sizeOf(reg.stock)+1); 
			blockWrite(a,reg,1);
			
			Write('Ingrese nombre: ');readln(reg.nombre);
				
		until reg.nombre='';
		close(a);
	end;


procedure recorrer(var a:archivo);
	var
		buffer,campo:string;
	begin
		reset(a,1);

		while not eof(a) do begin
			blockRead(a,buffer,1);
			write(buffer);
			while ( (buffer<>'#') AND (not eof(a)) ) do begin
				campo:='';
				while ( (buffer<>'@') AND  (buffer<>'#') AND  (not eof(a)) ) do begin
				 campo:=campo+buffer;
				 blockRead(a,buffer,1);
				end;
				write(campo,' ');
				if not eof(a) then blockRead(a,buffer,1);
				
			
			end;
					
		end;
		close(a);
	end;


var
	a:archivo;

begin
assign(a,'archivo.txt');
//crear(a);
recorrer(a);
end.
