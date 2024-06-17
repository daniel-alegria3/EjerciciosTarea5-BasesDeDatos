--- \skiplines{}
--- \item Relacion de prestatarios morosos, es decir, aquellos que aun no han
--- cancelado alguna de sus deudas y ya paso la fecha de vencimiento.

--- \begin{minted}[breaklines]{sql}
CREATE FUNCTION cr_PrestatariosMorosos()
RETURNS TABLE
AS RETURN (
    select P.CodPrestatario
    from Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    group BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento, P.Importe
    having SUM(IsNull(A.Importe, 0)) < P.Importe and GetDate() > P.FechaVencimiento
);
GO

select * from cr_PrestatariosMorosos();
go
--- \end{minted}

