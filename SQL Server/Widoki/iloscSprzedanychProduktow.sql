USE [HurtowniaSportowa]
GO

/****** Object:  View [dbo].[vw_ilosc_towar]    Script Date: 20.09.2020 23:31:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER     view [dbo].[vw_ilosc_towar]("Nazwa produktu", "Ilość sprzedanych sztuk") as
select towar.nazwaProduktu, sum(FakturaDetale.iloscZakupu) from FakturaDetale
join towar on towar.idProduktu = FakturaDetale.idProduktu
group by towar.nazwaProduktu;
GO

