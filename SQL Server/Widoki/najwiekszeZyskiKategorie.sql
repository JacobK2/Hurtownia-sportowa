USE [HurtowniaSportowa]
GO

/****** Object:  View [dbo].[vw_kategorie]    Script Date: 20.09.2020 23:32:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   view [dbo].[vw_kategorie]("Kategoria", "Wartość sprzedaży") as
select kategoria.nazwaKategorii, sum(Faktura.wartoscFaktury)
from Faktura
join FakturaDetale on FakturaDetale.idFaktury =
Faktura.idFaktury
join towar on towar.idProduktu = FakturaDetale.idProduktu
join kategoria on kategoria.idKategorii = towar.idKategorii
group by kategoria.nazwaKategorii;
GO

