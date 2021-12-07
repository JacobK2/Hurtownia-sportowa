USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Edytuj_Towar]    Script Date: 20.09.2020 23:37:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[Edytuj_Towar] (@idProduktu AS INT ,@nazwaProduktu AS VARCHAR(50) ,@cenaProduktu AS money, @iloscProduktu AS int, @idKategorii AS tinyint)
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		IF NOT EXISTS (select * from Towar where idProduktu = @idProduktu) 
		PRINT('Musi istnieć taki produkt')
		ELSE IF LEN(@nazwaProduktu) < 3 OR LEN(@nazwaProduktu) > 50 
		PRINT('Nazwa produktu musi zawierać od 3 do 50 znaków')
		ELSE IF @cenaProduktu IS NOT NULL AND @cenaProduktu <=0
		PRINT('Cena produktu nie może być mniejsza lub równa 0')
		ELSE IF @iloscProduktu IS NOT NULL AND @iloscProduktu < 0 OR @iloscProduktu > 1000
		PRINT('Ilość sztuk nie może być mniejsza od 0 oraz większa niż tysiąc')
		ELSE IF NOT EXISTS (select * from Kategoria where idKategorii = @idKategorii) 
		PRINT ('Musi istnieć taki rodzaj kategorii')
	ELSE
		UPDATE Towar
			SET	nazwaProduktu=ISNULL(@nazwaProduktu,nazwaProduktu),
				cenaProduktu=ISNULL(@cenaProduktu,cenaProduktu),
				iloscProduktu=ISNULL(@iloscProduktu,iloscProduktu),
				idKategorii=ISNULL(@idKategorii,idKategorii)
			WHERE idProduktu=@idProduktu 
		PRINT('Edytowano produkty!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END
GO

