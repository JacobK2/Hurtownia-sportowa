USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[raportProduktow]    Script Date: 20.09.2020 23:38:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER     PROC [dbo].[raportProduktow]
AS
BEGIN
DECLARE
	@produkt AS varchar(50),
	@wartoscSprzedazy AS money,
	@data as datetime
	SET @data = getdate()

DECLARE produkty_kursor CURSOR FOR
select * from vw_produkt
order by [Wartość sprzedaży] DESC;

OPEN produkty_kursor;
FETCH NEXT FROM  produkty_kursor INTO @produkt ,@wartoscSprzedazy;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 
		'     Produkt: ' + CAST(@produkt as nvarchar) +
		'     Wartość sprzedaży: ' + CAST(@wartoscSprzedazy as nvarchar);

		FETCH NEXT FROM  produkty_kursor INTO @produkt ,@wartoscSprzedazy;
		END;

CLOSE produkty_kursor
DEALLOCATE produkty_kursor
END;
GO

