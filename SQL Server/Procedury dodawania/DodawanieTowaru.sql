USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Dodaj_Towar]    Script Date: 20.09.2020 23:36:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[Dodaj_Towar] (@nazwaProduktu AS VARCHAR(50) ,@cenaProduktu AS money , @iloscProduktu AS INT, @idKategorii AS tinyint)
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		IF LEN(@nazwaProduktu) < 3 OR LEN(@nazwaProduktu) > 50 
		PRINT('Nazwa produktu musi zawierać od 3 do 50 znaków')
		ELSE IF NOT EXISTS (select * from Kategoria where idKategorii = @idKategorii) 
		PRINT ('Musi istnieć taki rodzaj kategorii')
		ELSE IF @cenaProduktu IS NOT NULL AND @cenaProduktu <=0
		PRINT('Cena produktu nie może być mniejsza lub równa 0')
		ELSE IF @iloscProduktu IS NOT NULL AND @iloscProduktu < 1 OR @iloscProduktu > 1000
		PRINT('Ilość sztuk nie może być mniejsza od 1 oraz większa niż tysiąc')
		ELSE
		INSERT INTO Towar(nazwaProduktu, cenaProduktu, iloscProduktu, idKategorii) VALUES
			(@nazwaProduktu, @cenaProduktu, @iloscProduktu, @idKategorii)			 
		PRINT('Dodano produkt!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END
GO

