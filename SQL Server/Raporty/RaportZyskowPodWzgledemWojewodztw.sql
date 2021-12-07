USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[raportWojewodztw]    Script Date: 20.09.2020 23:39:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROC [dbo].[raportWojewodztw]
AS
BEGIN
DECLARE
	@wojewodztwo AS varchar(30),
	@wartoscSprzedazy AS money,
	@data as datetime
	SET @data = getdate()

DECLARE wojewodztwa_kursor CURSOR FOR
select * from vw_wojewodztwa
order by [Wartość sprzedaży] DESC;

OPEN wojewodztwa_kursor;
FETCH NEXT FROM  wojewodztwa_kursor INTO @wojewodztwo, @wartoscSprzedazy;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 

		'     Województwo: ' + CAST(@wojewodztwo as nvarchar) +
		'     Wartość sprzedaży: ' + CAST(@wartoscSprzedazy as nvarchar);

		FETCH NEXT FROM  wojewodztwa_kursor INTO @wojewodztwo, @wartoscSprzedazy;
		END;

CLOSE wojewodztwa_kursor
DEALLOCATE wojewodztwa_kursor
END;
GO

