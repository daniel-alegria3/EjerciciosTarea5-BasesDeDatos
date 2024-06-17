--- \skiplines{}
--- \item Relacion de prestatarios que hasta la fecha hayan efectuado mas de 5
--- prestamos.

--- \begin{minted}[breaklines]{sql}
CREATE FUNCTION cr_PrestatariosConMasDeNPrestamos(@NroPrestamos INT)
RETURNS TABLE
AS RETURN (
    select Pio.CodPrestatario
    from Prestatario Pio inner join Prestamo Pmo on Pio.CodPrestatario = Pmo.CodPrestatario
    group by Pio.CodPrestatario
    having COUNT(Pmo.DocPrestamo) > @NroPrestamos
);
GO

select * from cr_PrestatariosConMasDeNPrestamos(5);
go
--- \end{minted}

