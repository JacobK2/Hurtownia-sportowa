USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[raportKatalogow]    Script Date: 20.09.2020 23:38:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROC [dbo].[raportKatalogow]
AS
BEGIN
DECLARE
	@kategoria AS varchar(40),
	@wartoscSprzedazy AS money,
	@data as datetime
	SET @data = getdate()

DECLARE kategorie_kursor CURSOR FOR
select * from vw_kategorie
order by [Wartość sprzedaży] DESC;

OPEN kategorie_kursor;
FETCH NEXT FROM  kategorie_kursor INTO @kategoria, @wartoscSprzedazy;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 

		'     Kategoria: ' + CAST(@kategoria as nvarchar) +
		'     Wartość sprzedaży: ' + CAST(@wartoscSprzedazy as nvarchar);

		FETCH NEXT FROM  kategorie_kursor INTO @kategoria, @wartoscSprzedazy;
		END;

CLOSE kategorie_kursor
DEALLOCATE kategorie_kursor
END;
GO

