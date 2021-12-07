USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Edytuj_Klienta]    Script Date: 20.09.2020 23:36:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [dbo].[Edytuj_Klienta] (@idKlienta AS int, @imie AS varchar(50), @nazwisko AS varchar(50), @nip AS varchar(25), @email AS varchar(50), @telefon AS varchar(25), @idWojewodztwa AS int)									
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		IF Not Exists (select * from Klient where idKlienta = @idKlienta) 
		PRINT('Musi istnieć taki klient')
		ELSE IF @imie IS NOT NULL AND (LEN(@imie) < 3 OR LEN(@imie) > 50)
		PRINT ('Imię musi mieć od 3 do 50 znaków')
		ELSE IF @nazwisko IS NOT NULL AND (LEN(@nazwisko) < 2 OR LEN(@nazwisko) > 50)
		PRINT('Nazwisko musi mieć od 3 do 50 znaków')
		ELSE IF @nip IS NOT NULL AND (LEN(@nip) < 10 OR LEN(@nip) > 11)
		PRINT(' Proszę wprowadzić NIP lub PESEL')
		ELSE IF ISNUMERIC(@nip)=0
		PRINT ('NIP lub PESEL składa się tylko z cyfr')
		ELSE IF ISNUMERIC(@telefon)=0
		PRINT ('Telefon składa się tylko z cyfr')
		ELSE IF NOT EXISTS (select * from Wojewodztwa where idWojewodztwa = @idWojewodztwa) 
		PRINT ('Musi istnieć takie województwo')
		ELSE
			UPDATE Klient
			SET	imie=ISNULL(@imie,imie),
				nazwisko=ISNULL(@nazwisko,nazwisko),
				nip=ISNULL(@nip,nip),
				email=ISNULL(@email,email),
				telefon=ISNULL(@telefon,telefon),
				idWojewodztwa=ISNULL(@idWojewodztwa,idWojewodztwa)
				WHERE idKlienta=@idKlienta
			 
		PRINT('Edytowano klienta!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END;
GO

