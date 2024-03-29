USE [master]
GO
/****** Object:  Database [HurtowniaSportowa]    Script Date: 20.09.2020 23:26:53 ******/
CREATE DATABASE [HurtowniaSportowa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HurtowniaSportowa', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HurtowniaSportowa.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HurtowniaSportowa_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HurtowniaSportowa_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HurtowniaSportowa] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HurtowniaSportowa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HurtowniaSportowa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET ARITHABORT OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HurtowniaSportowa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HurtowniaSportowa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HurtowniaSportowa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HurtowniaSportowa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET RECOVERY FULL 
GO
ALTER DATABASE [HurtowniaSportowa] SET  MULTI_USER 
GO
ALTER DATABASE [HurtowniaSportowa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HurtowniaSportowa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HurtowniaSportowa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HurtowniaSportowa] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HurtowniaSportowa] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HurtowniaSportowa', N'ON'
GO
ALTER DATABASE [HurtowniaSportowa] SET QUERY_STORE = OFF
GO
USE [HurtowniaSportowa]
GO
/****** Object:  Table [dbo].[Faktura]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faktura](
	[idFaktury] [int] IDENTITY(1,1) NOT NULL,
	[idKlienta] [int] NOT NULL,
	[dataFaktury] [datetime] NULL,
	[wartoscFaktury] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idFaktury] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Klient]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klient](
	[idKlienta] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](50) NOT NULL,
	[nazwisko] [varchar](50) NOT NULL,
	[nip] [varchar](25) NOT NULL,
	[email] [varchar](50) NULL,
	[telefon] [varchar](25) NOT NULL,
	[idWojewodztwa] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wojewodztwa]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wojewodztwa](
	[idWojewodztwa] [int] IDENTITY(1,1) NOT NULL,
	[nazwaWojewodztwa] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idWojewodztwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_wojewodztwa]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[vw_wojewodztwa]("Województwo", "Wartość sprzedaży")
as
select wojewodztwa.nazwaWojewodztwa,
sum(Faktura.wartoscFaktury) from Faktura
join klient on klient.idKlienta = Faktura.idKlienta
join wojewodztwa on wojewodztwa.idWojewodztwa = klient.idWojewodztwa
group by wojewodztwa.nazwaWojewodztwa;
GO
/****** Object:  View [dbo].[vw_klienci]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[vw_klienci]("Imię", "Nazwisko", "Wartość sprzedaży")
as
select klient.imie, klient.nazwisko ,
sum(Faktura.wartoscFaktury) from Faktura
join klient on klient.idKlienta = Faktura.idKlienta
group by klient.imie, klient.nazwisko;
GO
/****** Object:  Table [dbo].[FakturaDetale]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FakturaDetale](
	[idDetalu] [int] IDENTITY(1,1) NOT NULL,
	[idFaktury] [int] NOT NULL,
	[idProduktu] [int] NOT NULL,
	[iloscZakupu] [int] NOT NULL,
	[cenaZakupu] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idDetalu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Towar]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Towar](
	[idProduktu] [int] IDENTITY(1,1) NOT NULL,
	[nazwaProduktu] [varchar](50) NOT NULL,
	[cenaProduktu] [money] NOT NULL,
	[iloscProduktu] [int] NOT NULL,
	[idKategorii] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idProduktu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategoria]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategoria](
	[idKategorii] [tinyint] IDENTITY(1,1) NOT NULL,
	[nazwaKategorii] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idKategorii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_kategorie]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[vw_kategorie]("Kategoria", "Wartość sprzedaży") as
select kategoria.nazwaKategorii, sum(Faktura.wartoscFaktury)
from Faktura
join FakturaDetale on FakturaDetale.idFaktury =
Faktura.idFaktury
join towar on towar.idProduktu = FakturaDetale.idProduktu
join kategoria on kategoria.idKategorii = towar.idKategorii
group by kategoria.nazwaKategorii;
GO
/****** Object:  View [dbo].[vw_produkt]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[vw_produkt]("Produkt", "Wartość sprzedaży") as
select towar.nazwaProduktu, sum(Faktura.wartoscFaktury) from
Faktura
join FakturaDetale on FakturaDetale.idFaktury =
Faktura.idFaktury
join towar on towar.idProduktu = FakturaDetale.idProduktu
group by towar.nazwaProduktu;
GO
/****** Object:  View [dbo].[vw_ilosc_towar]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     view [dbo].[vw_ilosc_towar]("Nazwa produktu", "Ilość sprzedanych sztuk") as
select towar.nazwaProduktu, sum(FakturaDetale.iloscZakupu) from FakturaDetale
join towar on towar.idProduktu = FakturaDetale.idProduktu
group by towar.nazwaProduktu;
GO
SET IDENTITY_INSERT [dbo].[Faktura] ON 

INSERT [dbo].[Faktura] ([idFaktury], [idKlienta], [dataFaktury], [wartoscFaktury]) VALUES (1, 1, CAST(N'2020-09-20T21:19:51.780' AS DateTime), 50.0000)
INSERT [dbo].[Faktura] ([idFaktury], [idKlienta], [dataFaktury], [wartoscFaktury]) VALUES (2, 6, CAST(N'2020-09-20T21:21:16.233' AS DateTime), 1000.0000)
INSERT [dbo].[Faktura] ([idFaktury], [idKlienta], [dataFaktury], [wartoscFaktury]) VALUES (3, 1, CAST(N'2020-09-20T21:21:26.440' AS DateTime), 2000.0000)
INSERT [dbo].[Faktura] ([idFaktury], [idKlienta], [dataFaktury], [wartoscFaktury]) VALUES (4, 3, CAST(N'2020-09-20T21:21:32.883' AS DateTime), 500.0000)
INSERT [dbo].[Faktura] ([idFaktury], [idKlienta], [dataFaktury], [wartoscFaktury]) VALUES (5, 3, CAST(N'2020-09-20T21:21:58.090' AS DateTime), 100.0000)
SET IDENTITY_INSERT [dbo].[Faktura] OFF
GO
SET IDENTITY_INSERT [dbo].[FakturaDetale] ON 

INSERT [dbo].[FakturaDetale] ([idDetalu], [idFaktury], [idProduktu], [iloscZakupu], [cenaZakupu]) VALUES (1, 1, 1, 10, 1499.9000)
INSERT [dbo].[FakturaDetale] ([idDetalu], [idFaktury], [idProduktu], [iloscZakupu], [cenaZakupu]) VALUES (2, 2, 2, 10, 199.9000)
INSERT [dbo].[FakturaDetale] ([idDetalu], [idFaktury], [idProduktu], [iloscZakupu], [cenaZakupu]) VALUES (3, 2, 3, 5, 499.9500)
SET IDENTITY_INSERT [dbo].[FakturaDetale] OFF
GO
SET IDENTITY_INSERT [dbo].[Kategoria] ON 

INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (1, N'Bluzy')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (2, N'Spodnie')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (3, N'Spodenki')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (4, N'Podkoszulki')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (5, N'Odzież termoaktywna')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (6, N'Czapki')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (7, N'Kominy')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (8, N'Skarpetki')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (9, N'Bielizna')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (10, N'Rękawiczki')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (11, N'Buty do biegania')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (12, N'Buty do koszykówki')
INSERT [dbo].[Kategoria] ([idKategorii], [nazwaKategorii]) VALUES (13, N'Rakiety')
SET IDENTITY_INSERT [dbo].[Kategoria] OFF
GO
SET IDENTITY_INSERT [dbo].[Klient] ON 

INSERT [dbo].[Klient] ([idKlienta], [imie], [nazwisko], [nip], [email], [telefon], [idWojewodztwa]) VALUES (1, N'Jan', N'Abacki', N'1111111111', N'jan@abacki.com', N'123456789', 1)
INSERT [dbo].[Klient] ([idKlienta], [imie], [nazwisko], [nip], [email], [telefon], [idWojewodztwa]) VALUES (2, N'Adam', N'Bbacki', N'1111111112', N'adam@babacki.com', N'123456780', 2)
INSERT [dbo].[Klient] ([idKlienta], [imie], [nazwisko], [nip], [email], [telefon], [idWojewodztwa]) VALUES (3, N'Kamil', N'Obacki', N'1111111113', N'kamil@obacki.pl', N'123456781', 3)
INSERT [dbo].[Klient] ([idKlienta], [imie], [nazwisko], [nip], [email], [telefon], [idWojewodztwa]) VALUES (4, N'Piotrek', N'Klebacki', N'1111111114', N'piotrek@klebacki.com', N'123456782', 4)
INSERT [dbo].[Klient] ([idKlienta], [imie], [nazwisko], [nip], [email], [telefon], [idWojewodztwa]) VALUES (5, N'Józef', N'Opolański', N'1111111115', N'jozef@opolanski.edu.pl', N'123456783', 5)
INSERT [dbo].[Klient] ([idKlienta], [imie], [nazwisko], [nip], [email], [telefon], [idWojewodztwa]) VALUES (6, N'Sebastian', N'Korczak', N'98061503312', N'sebko@gmail.com', N'123123123', 2)
SET IDENTITY_INSERT [dbo].[Klient] OFF
GO
SET IDENTITY_INSERT [dbo].[Towar] ON 

INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (1, N'Bluza NIKE 001', 149.9900, 2000, 1)
INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (2, N'Bluza NIKE 002', 199.9900, 500, 1)
INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (3, N'Bluza ADIDAS 001', 99.9900, 2500, 1)
INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (4, N'Spodnie dresowe NIKE 001', 249.9900, 8000, 2)
INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (5, N'Spodnie dresowe ADIDAS 001', 149.9900, 6000, 2)
INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (6, N'Spodnie krótkie ADIDAS 001', 79.9900, 2000, 3)
INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (7, N'Podkoszulka Reebok 001', 79.9900, 2000, 4)
INSERT [dbo].[Towar] ([idProduktu], [nazwaProduktu], [cenaProduktu], [iloscProduktu], [idKategorii]) VALUES (8, N'Czapka PUMA 001', 39.9900, 12000, 6)
SET IDENTITY_INSERT [dbo].[Towar] OFF
GO
SET IDENTITY_INSERT [dbo].[Wojewodztwa] ON 

INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (1, N'dolnośląskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (2, N'kujawsko-pomorskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (3, N'lubelskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (4, N'lubuskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (5, N'łódzkie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (6, N'małopolskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (7, N'mazowieckie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (8, N'opolskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (9, N'podkarpackie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (10, N'podlaskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (11, N'pomorskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (12, N'śląskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (13, N'świętokrzyskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (14, N'warmińsko-mazurskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (15, N'wielkopolskie')
INSERT [dbo].[Wojewodztwa] ([idWojewodztwa], [nazwaWojewodztwa]) VALUES (16, N'zachodniopomorskie')
SET IDENTITY_INSERT [dbo].[Wojewodztwa] OFF
GO
ALTER TABLE [dbo].[Faktura] ADD  DEFAULT (getdate()) FOR [dataFaktury]
GO
ALTER TABLE [dbo].[Faktura]  WITH CHECK ADD FOREIGN KEY([idKlienta])
REFERENCES [dbo].[Klient] ([idKlienta])
GO
ALTER TABLE [dbo].[FakturaDetale]  WITH CHECK ADD FOREIGN KEY([idFaktury])
REFERENCES [dbo].[Faktura] ([idFaktury])
GO
ALTER TABLE [dbo].[FakturaDetale]  WITH CHECK ADD FOREIGN KEY([idProduktu])
REFERENCES [dbo].[Towar] ([idProduktu])
GO
ALTER TABLE [dbo].[Klient]  WITH CHECK ADD FOREIGN KEY([idWojewodztwa])
REFERENCES [dbo].[Wojewodztwa] ([idWojewodztwa])
GO
ALTER TABLE [dbo].[Towar]  WITH CHECK ADD FOREIGN KEY([idKategorii])
REFERENCES [dbo].[Kategoria] ([idKategorii])
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_Faktura_Detale]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_Faktura_Detale] (@idFaktury AS int, @idProduktu AS int, @iloscZakupu AS int, @cenaZakupu AS money)
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
/****** Object:  StoredProcedure [dbo].[Dodaj_Fakture]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_Fakture] (@idKlienta AS int, @wartoscFaktury AS money)
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
/****** Object:  StoredProcedure [dbo].[Dodaj_Klienta]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE       PROCEDURE [dbo].[Dodaj_Klienta] (@imie AS varchar(50), @nazwisko AS varchar(50), @nip AS varchar(25), @email AS varchar(50), @telefon AS varchar(25), @idWojewodztwa AS int)
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
/****** Object:  StoredProcedure [dbo].[Dodaj_Towar]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Dodaj_Towar] (@nazwaProduktu AS VARCHAR(50) ,@cenaProduktu AS money , @iloscProduktu AS INT, @idKategorii AS tinyint)
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
/****** Object:  StoredProcedure [dbo].[Edytuj_Fakture]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Edytuj_Fakture] (@idFaktury AS int, @idKlienta AS int, @wartoscFaktury AS money)
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
/****** Object:  StoredProcedure [dbo].[Edytuj_Fakture_Detale]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROCEDURE [dbo].[Edytuj_Fakture_Detale] (@idDetalu AS int, @idFaktury AS int, @idProduktu AS int, @iloscZakupu AS int, @cenaZakupu AS money)
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
/****** Object:  StoredProcedure [dbo].[Edytuj_Klienta]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Edytuj_Klienta] (@idKlienta AS int, @imie AS varchar(50), @nazwisko AS varchar(50), @nip AS varchar(25), @email AS varchar(50), @telefon AS varchar(25), @idWojewodztwa AS int)									
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
/****** Object:  StoredProcedure [dbo].[Edytuj_Towar]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[Edytuj_Towar] (@idProduktu AS INT ,@nazwaProduktu AS VARCHAR(50) ,@cenaProduktu AS money, @iloscProduktu AS int, @idKategorii AS tinyint)
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
/****** Object:  StoredProcedure [dbo].[raportIloscTowarow]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROC [dbo].[raportIloscTowarow]
AS
BEGIN
DECLARE
	@produkt AS varchar(50),
	@ilosc AS int,
	@data as datetime
	SET @data = getdate()

DECLARE ilosc_kursor CURSOR FOR
select * from vw_ilosc_towar
order by [Ilość sprzedanych sztuk] DESC;

OPEN ilosc_kursor;
FETCH NEXT FROM  ilosc_kursor INTO @produkt ,@ilosc;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 
		'     Produkt: ' + CAST(@produkt as nvarchar) +
		'     Ilość sprzedancyh sztuk: ' + CAST(@ilosc as nvarchar);

		FETCH NEXT FROM  ilosc_kursor INTO @produkt ,@ilosc;
		END;

CLOSE ilosc_kursor
DEALLOCATE ilosc_kursor
END;
GO
/****** Object:  StoredProcedure [dbo].[raportKatalogow]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[raportKatalogow]
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
/****** Object:  StoredProcedure [dbo].[raportKlientow]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[raportKlientow]
AS
BEGIN
DECLARE
	@imie AS varchar(50),
	@nazwisko AS varchar(50),
	@wartoscSprzedazy AS money,
	@data as datetime
	SET @data = getdate()

DECLARE klienci_kursor CURSOR FOR
select * from vw_klienci
order by [Wartość sprzedaży] DESC;

OPEN klienci_kursor;
FETCH NEXT FROM  klienci_kursor INTO @imie, @nazwisko ,@wartoscSprzedazy;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 
		'     Imię: ' + CAST(@imie as nvarchar) +
		'     Nazwisko: ' + CAST(@nazwisko as nvarchar) +
		'     Wartość sprzedaży: ' + CAST(@wartoscSprzedazy as nvarchar);

		FETCH NEXT FROM  klienci_kursor INTO @imie, @nazwisko, @wartoscSprzedazy;
		END;

CLOSE klienci_kursor
DEALLOCATE klienci_kursor
END;
GO
/****** Object:  StoredProcedure [dbo].[raportProduktow]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROC [dbo].[raportProduktow]
AS
BEGIN
DECLARE
	@produkt AS varchar(50),
	@wartoscSprzedazy AS money,
	@data as datetime
	SET @data = getdate()

DECLARE produkty_kursor CURSOR FOR
select * from vw_produkt
order by [Wartość sprzedaży] DESC;

OPEN produkty_kursor;
FETCH NEXT FROM  produkty_kursor INTO @produkt ,@wartoscSprzedazy;
print '     raport wykonano: '   + CAST(@data As nvarchar);
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 
		'     Produkt: ' + CAST(@produkt as nvarchar) +
		'     Wartość sprzedaży: ' + CAST(@wartoscSprzedazy as nvarchar);

		FETCH NEXT FROM  produkty_kursor INTO @produkt ,@wartoscSprzedazy;
		END;

CLOSE produkty_kursor
DEALLOCATE produkty_kursor
END;
GO
/****** Object:  StoredProcedure [dbo].[raportWojewodztw]    Script Date: 20.09.2020 23:26:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[raportWojewodztw]
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
USE [master]
GO
ALTER DATABASE [HurtowniaSportowa] SET  READ_WRITE 
GO
