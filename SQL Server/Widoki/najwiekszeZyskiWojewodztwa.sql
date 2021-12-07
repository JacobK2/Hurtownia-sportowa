USE [HurtowniaSportowa]
GO

/****** Object:  View [dbo].[vw_wojewodztwa]    Script Date: 20.09.2020 23:33:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   view [dbo].[vw_wojewodztwa]("Województwo", "Wartość sprzedaży")
as
select wojewodztwa.nazwaWojewodztwa,
sum(Faktura.wartoscFaktury) from Faktura
join klient on klient.idKlienta = Faktura.idKlienta
join wojewodztwa on wojewodztwa.idWojewodztwa = klient.idWojewodztwa
group by wojewodztwa.nazwaWojewodztwa;
GO

