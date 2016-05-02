{
ejemplo de arbol binario
   
}

program arboloBinario;

type 
	nodo= record 
	  elemento:String;
	  hIzq:integer;
	  hDer:integer; 
	end;
	
archivo=file of nodo;

procedure insertar (var A:archivo; var elem:String);
  var 
    raiz,nodo_nuevo:nodo;
    pos_nuevo_nodo:integer;
    encontre_padre,first:boolean;
  
  begin
	reset(A);
	
	with nodo_nuevo do begin
	  elemento:=elem;
	  hIzq:=-1;
	  hDer:=-1;
	end;
	
	if Eof (A) then begin //arbol vacio
	  Write(A,nodo_nuevo);
	  encontre_padre:=true;
	  first:=true;
	  end
	else 
	  begin
	  Read(A,raiz);
	  pos_nuevo_nodo:=filesize(A);
	  seek(A,pos_nuevo_nodo);
	  write(A,nodo_nuevo);
	  encontre_padre:=false;
	  first:=false;
	end;
	  
	//buscar al nuevo padre para agregar la referencia al nuevo nodo. 
	while (not encontre_padre)do 
	  begin
	  
		if ( raiz.elemento> nodo_nuevo.elemento ) then
		begin
		  if ( raiz.hIzq<>-1) then begin
		    seek(A, raiz.hIzq);
		    read (A,raiz);
			end
		  else begin
		    raiz.hIzq:=pos_nuevo_nodo;
		    encontre_padre:=true;
			end;
		end  
		
		else
		  if (raiz.hDer<>-1) then begin
			seek(A,raiz.hDer);
			read(A,raiz);
			end
		  else
			begin
			raiz.hDer:=pos_nuevo_nodo;
			encontre_padre:=true;
			end;
		end;
	
	if (not first) then begin
	  seek(A,filePos(A)-1);
	  write(A,raiz);
	  end;
	close(A);

  end;
var 
A:archivo;
text:string;
BEGIN
assign (A,'TEST.bin');
rewrite(A);
close(A);
text:='asdad';
insertar(A,text);
text:='r';
insertar(A,text);
	
END.

