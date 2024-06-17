--- \skiplines{1}
--- \item Relacion de prestamos efectuados por los prestatarios de una
--- determinanda comunidad.

--- \begin{minted}[breaklines]{sql}
CREATE FUNCTION cr_PrestamosDeComunidad(@CodComunidad TCodComunidad)
RETURNS TABLE
AS RETURN (
    select Pmo.DocPrestamo
    from Prestatario Pio inner join Prestamo Pmo on Pio.CodPrestatario = Pmo.CodPrestatario
    where Pio.CodComunidad = @CodComunidad
);
GO

select * from cr_PrestamosDeComunidad("C001");
go
--- \end{minted}

