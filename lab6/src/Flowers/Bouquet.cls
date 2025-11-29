Class Flowers.Bouquet Extends (%Persistent)
{
Property Style As %String;
Property Message As %Stream.GlobalCharacter;
Property Flowers As list Of Flowers.Flower;
Property Decorations As list Of Flowers.Decoration;
Property Price As %Numeric;
Query AllBouquets() As %SQLQuery
{
    SELECT ID, Style, Price FROM Flowers.Bouquet ORDER BY Price DESC
}
ClassMethod GetMostExpensiveBouquet() As %String
{
    Set sql = "SELECT TOP 1 Style, Price FROM Flowers.Bouquet ORDER BY Price DESC"
    Set stmt = ##class(%SQL.Statement).%New()
    Set sc = stmt.%Prepare(sql)
    If $$$ISERR(sc) Quit "Error"
    Set rs = stmt.%Execute()
    If rs.%Next() Quit rs.%Get("Style")_" ($"_rs.%Get("Price")_")"
    Quit "Not found"
}
}
