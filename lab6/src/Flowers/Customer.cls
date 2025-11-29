Class Flowers.Customer Extends (%Persistent)
{
Property Name As %String(MINLEN=3, MAXLEN=80);
Property Phone As %String;
Property Email As %String [ Required ];
Relationship Orders As list Of Flowers.Order [ Cardinality = many, Inverse = Customer ];
Index EmailIndex On Email [ IdKey ];
Query CustomersWithOrders() As %SQLQuery
{
    SELECT c.Email, c.Name, o.OrderId, o.Total, o.HandledBy->Name AS EmployeeName
    FROM Flowers.Customer c, Flowers."Order" o
    WHERE o.Customer = c.Email
    ORDER BY c.Name
}
}
