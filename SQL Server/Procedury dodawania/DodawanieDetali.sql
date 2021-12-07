USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Dodaj_Faktura_Detale]    Script Date: 20.09.2020 23:35:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[Dodaj_Faktura_Detale] (@idFaktury AS int, @idProduktu AS int, @iloscZakupu AS int, @cenaZakupu AS money)
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	    IF NOT EXISTS (select * from Faktura where idFaktury = @idFaktury) 
		PRINT('Musi istnieć taka faktura')
		ELSE IF NOT EXISTS (select * from Towar where idProduktu = @idProduktu) 
		PRINT('Musi istnieć taki produkt')
		ELSE
		INSERT INTO FakturaDetale(idFaktury, idProduktu, iloscZakupu, cenaZakupu) VALUES
			(@idFaktury, @idProduktu, @iloscZakupu, @cenaZakupu)
			 
		PRINT('Dodano pozycję!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END
GO

