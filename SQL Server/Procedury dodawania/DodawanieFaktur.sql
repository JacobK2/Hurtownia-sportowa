USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Dodaj_Fakture]    Script Date: 20.09.2020 23:35:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[Dodaj_Fakture] (@idKlienta AS int, @wartoscFaktury AS money)
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	IF NOT EXISTS (select * from Klient where idKlienta = @idKlienta) 
	PRINT( 'Faktura musi mieć swojego klienta')
		 ELSE 
		INSERT INTO Faktura(idKlienta, wartoscFaktury) VALUES
			(@idKlienta, @wartoscFaktury)
			 
		PRINT('Dodano fakturę!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END
GO

