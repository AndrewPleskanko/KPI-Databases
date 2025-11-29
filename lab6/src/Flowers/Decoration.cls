Class Flowers.Decoration Extends Flowers.Plant
{
Property Material As %String;
Property Reusable As %Boolean;
Query AllDecorations() As %SQLQuery
{
    SELECT ID, Name, Material, Reusable FROM Flowers.Decoration ORDER BY Name
}
}
