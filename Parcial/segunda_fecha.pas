program Parcial-segunda-fecha;
uses crt;
const valorAlto=9999;

type
  tProducto = record
    codigo:integer;
    nombre:string[50];
    presentacion: string[50];
  end;
tArchProductos=file of tProducto;

procedure leer(var a:tArchProductos;var r:tProducto);
  begin
    if (not eof (a)) then read(a,r) else
      r.codigo:=valorAlto;
  end;

procedure agregar(var a: tArchProductos; producto:tProducto);
  var
    cabecera:tProducto;
  begin
    reset(a);
    leer(a,cabecera);
    if cabecera.codigo<0 then
      begin
        seek(a,cabecera.codigo*-1);
        leer(a,cabecera);
        seek(a,filePos(a)-1);
        write(a,producto);
        seek(a,0);
        write(a,cabecera);
      end
    else
      begin
        seek(a,fileSize(a));
        write(a,producto);
      end;
    close(a);
  end;

procedure eliminar(var a:tArchProductos;var producto:tProducto);
  var
    cabecera,registro:tProducto;
  begin
    reset(a);
    leer(a,registro);
    cabecera:=registro;
    while (( registro.codigo <> producto.codigo ) 
              AND ( registro.codigo<>valorAlto )) DO
      begin
        leer(a,registro);
      end;
    if registro.codigo<>valorAlto then
      begin
        seek(a,filepos(a)-1);
        write(a,cabecera);
        cabecera.codigo:=((filePos(a)-1)*-1);
        seek(a,0);
        write(a,cabecera);
      end;
    close(a);
  end;


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
procedure  cargar(var a:tArchProductos);
  var
    registro:tProducto;
  begin
    rewrite(a);
    registro.codigo:=0;
    registro.nombre:='';
    registro.presentacion:='';
    write(a,registro); 
    writeln('Ingrese Numero: ');
    read(registro.codigo);
    while registro.codigo<>99 do 
      begin
        clrscr;
        write(a,registro);
        writeln('Ingrese Numero: ');
        read(registro.codigo);
      end;
    close(a);
  end;

procedure recorrer(var a:tArchProductos);
  var
    reg:tProducto;
  begin
  reset(a);
  leer(a,reg);
  while reg.codigo<>valorAlto do
    begin
      write(reg.codigo,'  ');
      leer(a,reg);
    end;
    
  close(a);
  end;
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
var a:tArchProductos;  
reg:tProducto;
begin
  assign(a,'productos.bin');
  //cargar(a);
  recorrer(a);
  reg.codigo:=333;
  agregar(a,reg);
  writeln();
recorrer(a);


end.
