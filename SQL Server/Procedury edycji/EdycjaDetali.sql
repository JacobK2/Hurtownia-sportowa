USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Edytuj_Fakture_Detale]    Script Date: 20.09.2020 23:36:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER     PROCEDURE [dbo].[Edytuj_Fakture_Detale] (@idDetalu AS int, @idFaktury AS int, @idProduktu AS int, @iloscZakupu AS int, @cenaZakupu AS money)
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY

	IF Not Exists (select * from Faktura where idFaktury = @idFaktury) 
	PRINT('Musi istnieć taka faktura')
	IF NOT EXISTS (select * from FakturaDetale where idDetalu = @idDetalu) 
	PRINT( 'Faktura musi mieć swoje detale')
	IF NOT EXISTS (select * from Towar where idProduktu = @idProduktu) 
	PRINT( 'Faktura musi mieć swój produkt')
	
	UPDATE FakturaDetale
		SET	idFaktury=ISNULL(@idFaktury,idFaktury),
			idProduktu=ISNULL(@idProduktu,idProduktu),
			iloscZakupu=ISNULL(@iloscZakupu,iloscZakupu),
			cenaZakupu=ISNULL(@cenaZakupu,cenaZakupu)
			WHERE idDetalu=@idDetalu;			 
		PRINT('Edytowano detal faktury!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END
GO

