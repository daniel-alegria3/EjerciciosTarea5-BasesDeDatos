--- \skiplines{1}
--- \item Relacion de comunidades que no tengan prestatarios morosos.

--- \begin{minted}[breaklines]{sql}
CREATE FUNCTION cr_ComunidadesSinMorosos()
RETURNS TABLE
AS RETURN (
    with
    Moroso(CodPrestatario) as (
        select P.CodPrestatario
        from Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
        group BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento, P.Importe
        having SUM(IsNull(A.Importe, 0)) < P.Importe and GetDate() > P.FechaVencimiento
    ),
    ComunidadMorosa (CodComunidad) as (
        select P.CodComunidad
        from Prestatario P inner join Moroso M on P.CodPrestatario = M.CodPrestatario
    )
    select C.CodComunidad
    from Comunidad C inner join ComunidadMorosa Cm on C.CodComunidad != Cm.CodComunidad
);
GO

select * from cr_ComunidadesSinMorosos();
go
--- \end{minted}

