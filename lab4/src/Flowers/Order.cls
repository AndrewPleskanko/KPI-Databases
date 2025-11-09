Class Flowers.Order Extends (%Persistent)
{
Property OrderId As %Integer [ Required ];
Property OrderDate As %Date;
Relationship Customer As Flowers.Customer [ Cardinality = one, Inverse = Orders ];
Property HandledBy As Flowers.Employee;
Relationship Items As list Of Flowers.OrderItem [ Cardinality = many, Inverse = Order ];
Property Total As %Numeric(MINVAL=1, MAXVAL=10000);

Index OrderIdIndex On OrderId [ Unique ];
}