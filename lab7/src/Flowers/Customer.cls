Class Flowers.Customer Extends (%Persistent)
{
Property Name As %String(MINLEN=3, MAXLEN=80);
Property Phone As %String;
Property Email As %String [ Required ];
Relationship Orders As list Of Flowers.Order [ Cardinality = many, Inverse = Customer ];

Index EmailIndex On Email [ Unique ];
}
