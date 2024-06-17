--- \skiplines{}
--- \item Relacion de comunidades cuyos prestatarios que aun tienen saldos, no
--- hayan efectuado ninguna amortizacion en lo que va del año 2004.

--- \begin{minted}[breaklines]{sql}
-- La pregunta creo que se refereia a "Prestatarios que aun tienen saldo en
-- un(os) Prestamos, y no hayan efectuado ninguna amortizacion a ese
-- Prestamo en lo que va del año 2004". Es muy tarde ahora y no quiero ser
-- linguista.

CREATE FUNCTION cr_ComunidadesCuyosPrestatariosAunTienesSaldoYNoAmortizaronEnElAnioN(@Anio INT)
RETURNS TABLE
AS RETURN (
    with
    -- Prestatarios con saldo
    R1 (CodComunidad, CodPrestatario, DocPrestamo) as (
        select P.CodComunidad, P.CodPrestatario, P.DocPrestamo
        from Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
        group by P.CodPrestatario, P.DocPrestamo
        having P.Importe > SUM(IsNull(A.Importe, 0)))
    ),
    -- Amortizacion en 2004
    R2 (CodPrestatario) as (
        select R1.CodPrestatario
        from R1 inner join Amortizacion A on R1.DocPrestamo = A.DocPrestamo
        where R1.CodPrestatario = A.CodPrestatario and
              DATEPART(year, A.FechaCancelacion) = @Anio
    ),
    select R1.CodComunidad
    from R1, R2
    where R1.CodPrestatario != R2.CodPrestatario
);
GO

select * from cr_ComunidadesCuyosPrestatariosAunTienesSaldoYnoAmortizaronEnElAnioN(2004);
-- Con la base de datos de prueba, siempre te da 40
go
--- \end{minted}

