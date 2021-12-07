USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[raportKlientow]    Script Date: 20.09.2020 23:38:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROC [dbo].[raportKlientow]
AS
BEGIN
DECLARE
	@imie AS varchar(50),
	@nazwisko AS varchar(50),
	@wartoscSprzedazy AS money,
	@data as datetime
	SET @data = getdate()

DECLARE klienci_kursor CURSOR FOR
select * from vw_klienci
order by [Wartość sprzedaży] DESC;

OPEN klienci_kursor;
FETCH NEXT FROM  klienci_kursor INTO @imie, @nazwisko ,@wartoscSprzedazy;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 
		'     Imię: ' + CAST(@imie as nvarchar) +
		'     Nazwisko: ' + CAST(@nazwisko as nvarchar) +
		'     Wartość sprzedaży: ' + CAST(@wartoscSprzedazy as nvarchar);

		FETCH NEXT FROM  klienci_kursor INTO @imie, @nazwisko, @wartoscSprzedazy;
		END;

CLOSE klienci_kursor
DEALLOCATE klienci_kursor
END;
GO

