USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[raportIloscTowarow]    Script Date: 20.09.2020 23:37:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER     PROC [dbo].[raportIloscTowarow]
AS
BEGIN
DECLARE
	@produkt AS varchar(50),
	@ilosc AS int,
	@data as datetime
	SET @data = getdate()

DECLARE ilosc_kursor CURSOR FOR
select * from vw_ilosc_towar
order by [Ilość sprzedanych sztuk] DESC;

OPEN ilosc_kursor;
FETCH NEXT FROM  ilosc_kursor INTO @produkt ,@ilosc;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 
		'     Produkt: ' + CAST(@produkt as nvarchar) +
		'     Ilość sprzedancyh sztuk: ' + CAST(@ilosc as nvarchar);

		FETCH NEXT FROM  ilosc_kursor INTO @produkt ,@ilosc;
		END;

CLOSE ilosc_kursor
DEALLOCATE ilosc_kursor
END;
GO

