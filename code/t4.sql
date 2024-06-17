--- \skiplines{}
--- \item Relacion de las 5 comunidades que tienen el mayor numero de
--- prestatarios.

--- \begin{minted}[breaklines]{sql}
CREATE FUNCTION cr_NComunidadesConElMayorNumeroDePrestatarios(@NroComunidades INT)
RETURNS TABLE
AS RETURN (
    select TOP(@NroComunidades) C.CodComunidad, COUNT(P.CodPrestatario) as NroPrestatarios
    from Comunidad C inner join Prestatario P on C.CodComunidad = P.CodComunidad
    group BY C.CodComunidad
    order BY NroPrestatarios DESC
);
GO

select * from cr_NComunidadesConElMayorNumeroDePrestatarios(5);
go
--- \end{minted}

