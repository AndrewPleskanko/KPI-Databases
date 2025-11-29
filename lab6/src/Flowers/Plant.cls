Class Flowers.Plant Extends (%Persistent, %XML.Adaptor)
{
Property Name As %String(MINLEN=2, MAXLEN=100);
Property Color As %String;
Property FreshDays As %Integer(MINVAL=1, MAXVAL=30);
Property Photo As %Stream.GlobalBinary;
Query AllPlants() As %SQLQuery
{
    SELECT ID, Name, Color, FreshDays FROM Flowers.Plant ORDER BY Name
}
Query FindByColor(targetColor As %String) As %SQLQuery
{
    SELECT ID, Name, FreshDays FROM Flowers.Plant
    WHERE Color = :targetColor
}

}