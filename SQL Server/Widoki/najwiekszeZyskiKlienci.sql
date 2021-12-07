USE [HurtowniaSportowa]
GO

/****** Object:  View [dbo].[vw_klienci]    Script Date: 20.09.2020 23:32:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   view [dbo].[vw_klienci]("Imię", "Nazwisko", "Wartość sprzedaży")
as
select klient.imie, klient.nazwisko ,
sum(Faktura.wartoscFaktury) from Faktura
join klient on klient.idKlienta = Faktura.idKlienta
group by klient.imie, klient.nazwisko;
GO

