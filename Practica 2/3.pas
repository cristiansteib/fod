{
   3.pas
   * 
   * no estoy seguro si es la manera de implementar la solucion.
   
    
}


program untitled;
uses crt;
const valorAlto=9999;

type 
	producto=RECORD 
		codigo:integer;
		descripcion:string[50];
		stockActual:integer;
		stockMinimo:integer;
	end;
	
	pedido=RECORD
		codigo:integer;
		cantidad:integer;
	end;
	
aMae=file of producto;
aDet=file of pedido;


procedure leer(var a:aDet;var r:pedido);
	begin
		if (not eof(a)) then 
			read(a,r)
		else
			r.codigo:=valorAlto;
	end;


procedure minimo(var det1,det2,det3:pedido ;var adet1,adet2,adet3:aDet;var min:pedido);
	begin
		if ((det1.codigo<=det2.codigo) and (det1.codigo<=det3.codigo)) then begin
			min:=det1;
			leer(adet1,det1);
			end
		else if ((det2.codigo<=det1.codigo) and (det2.codigo<=det3.codigo)) then begin
			min:=det2;
			leer(adet2,det2);
			end
		else begin
			min:=det3;
			leer(adet3,det3);
			end;
	end;


procedure actualizar_maestro(var adet1,adet2,adet3:aDet; var mae:Amae);
	var
		cod_ant:integer;
		cantidad:integer;
		regMae:producto;
		regMin,regDet1,regDet2,regDet3:pedido;
		posR1,posR2,posR3 : integer; // las uso para controlar la posicion y saber cual fue el minimo.
		numero:integer;
		
	begin
		reset(adet1);reset(adet2);reset(adet3);
		reset(mae);
		read (mae,regMae);
		leer(adet1,regDet1);
		leer(adet2,regDet2);
		leer(adet3,regDet3);
		
		posR1:=filePos(adet1);
		posR2:=filePos(adet2);
		posR3:=filePos(adet3);
		
		minimo(regDet1,regDet2,regDet3,adet1,adet2,adet3,regMin);
		
		while regMin.codigo<>valorAlto do begin
			
			
			cod_ant:=regMin.codigo;
			cantidad:=0;
			
			while regMae.codigo<>cod_ant do 
				read(mae,regMae);  // no controlo fin , se supone que el codigo del detalle existe en el maestro. 
				
			while cod_ant=regMin.codigo do begin   //mientras sea el mismo producto
				
				
				if ((regMae.stockActual-regMin.cantidad)>0) then begin
					regMae.stockActual:=regMae.stockActual-regMin.cantidad;  end
				  else begin
						Writeln('La diferencia que no se puede entregar es de : ',regMae.stockActual-regMin.cantidad);
						if filePos(adet1) <> posR1 then numero:=1;
						if filePos(adet2) <> posR2 then numero:=2;
						if filePos(adet3) <> posR3 then numero:=3;
						Writeln('Al restaurant N°: ',numero);
						Writeln;
						regMae.stockActual:=0;
					end;
				
				posR1:=filePos(adet1);
				posR2:=filePos(adet2);
				posR3:=filePos(adet3);
				
				minimo(regDet1,regDet2,regDet3,adet1,adet2,adet3,regMin);
								
			end;
			
			seek(mae,filePos(mae)-1);
			write(mae,regMae);
			
			if not eof(mae) then
				read(mae,regMae);
		end;
	end;
	
	
	

var
 
mae:aMae;
det1,det2,det3:aDet;
regm:producto;

BEGIN
	Writeln('RESTAURANTES');
	assign(det1,'detalle1.bin');
	assign(det2,'detalle2.bin');
	assign(det3,'detalle3.bin');
	assign(mae,'maestro.bin');
	actualizar_maestro(det1,det2,det3,mae);	
END.

