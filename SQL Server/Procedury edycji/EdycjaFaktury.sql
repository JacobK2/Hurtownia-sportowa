USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Edytuj_Fakture]    Script Date: 20.09.2020 23:36:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[Edytuj_Fakture] (@idFaktury AS int, @idKlienta AS int, @wartoscFaktury AS money)
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY

	IF Not Exists (select * from Faktura where idFaktury = @idFaktury) 
	PRINT('Musi istnieć taka faktura')
	IF NOT EXISTS (select * from Klient where idKlienta = @idKlienta) 
	PRINT( 'Faktura musi mieć swojego klienta')
	
	UPDATE Faktura
		SET	wartoscFaktury=ISNULL(@wartoscFaktury,wartoscFaktury),
			idKlienta=ISNULL(@idKlienta,idKlienta),
			dataFaktury=GETDATE()
			WHERE idFaktury=@idFaktury;			 
		PRINT('Edytowano Fakture!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END
GO

