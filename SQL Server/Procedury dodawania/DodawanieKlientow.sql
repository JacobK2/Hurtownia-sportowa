USE [HurtowniaSportowa]
GO

/****** Object:  StoredProcedure [dbo].[Dodaj_Klienta]    Script Date: 20.09.2020 23:35:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE OR ALTER       PROCEDURE [dbo].[Dodaj_Klienta] (@imie AS varchar(50), @nazwisko AS varchar(50), @nip AS varchar(25), @email AS varchar(50), @telefon AS varchar(25), @idWojewodztwa AS int)
	AS
	BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	      IF @imie IS NOT NULL AND LEN(@imie) < 3 OR LEN(@imie) > 50
		  PRINT ('Nazwa imienia musi zawierać od 3 do 50 znaków')
		  ELSE IF @nazwisko IS NOT NULL AND LEN(@nazwisko) < 3 OR LEN(@nazwisko) > 50 
		  PRINT ('Nazwisko może zawierać od 3 do 50 znaków')
		  ELSE IF @nip IS NOT NULL AND LEN(@nip) < 10 OR LEN(@nip) > 11 
		  PRINT ('Proszę wprowadzić NIP lub PESEL')
		  ELSE IF ISNUMERIC(@nip)=0
		  PRINT ('NIP lub PESEL składa się tylko z cyfr')
		  ELSE IF ISNUMERIC(@telefon)=0
		  PRINT ('Telefon składa się tylko z cyfr')
		  ELSE IF NOT EXISTS (select * from Wojewodztwa where idWojewodztwa = @idWojewodztwa) 
		  PRINT ('Musi istnieć takie województwo')
		  INSERT INTO Klient(imie, nazwisko, nip, email, telefon, idWojewodztwa ) VALUES
			(@imie, @nazwisko , @nip, @email, @telefon, @idWojewodztwa )			 
		PRINT('Dodano klienta!')
	END TRY
	BEGIN CATCH
		PRINT('Wystąpił błąd:')
		PRINT(ERROR_MESSAGE())
	END CATCH
END
GO

