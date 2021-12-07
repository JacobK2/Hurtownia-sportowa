USE [HurtowniaSportowa]
GO

/****** Object:  View [dbo].[vw_produkt]    Script Date: 20.09.2020 23:32:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   view [dbo].[vw_produkt]("Produkt", "Wartość sprzedaży") as
select towar.nazwaProduktu, sum(Faktura.wartoscFaktury) from
Faktura
join FakturaDetale on FakturaDetale.idFaktury =
Faktura.idFaktury
join towar on towar.idProduktu = FakturaDetale.idProduktu
group by towar.nazwaProduktu;
GO

