Class Flowers.Order Extends %Persistent
{
Property OrderId As %Integer [ Required ];
Property OrderDate As %Date;
Relationship Customer As Flowers.Customer [ Cardinality = one, Inverse = Orders ];
Property HandledBy As Flowers.Employee;
Relationship Items As list Of Flowers.OrderItem [ Cardinality = many, Inverse = Order ];
Property Total As %Numeric(MINVAL=0, MAXVAL=10000);
Property TotalWithTax As %Numeric [ Calculated ];
Method TotalWithTaxGet() As %Numeric
{
    Set t = ..Total
    If t="" Set t = 0
    Quit t * 1.20
}
Index OrderIdIndex On OrderId [ IdKey ];
Query OrdersWithDetails() As %SQLQuery
{
    SELECT o.OrderId, o.Total, o.Customer->Name AS CustomerName, o.HandledBy->Name AS EmployeeName
    FROM Flowers."Order" o ORDER BY o.OrderDate DESC
}
ClassMethod GetTotalSales() As %Numeric
{
    Set total = 0
    &sql(SELECT SUM(Total) INTO :total FROM Flowers."Order")
    Quit $Select(total="":0, 1:total)
}
ClassMethod ShowLargeOrders(minTotal As %Numeric)
{
    Write "--- Large Orders (> ", minTotal, ") ---",!
    &sql(DECLARE OrderCursor CURSOR FOR
         SELECT OrderId, Total INTO :id, :amt
         FROM Flowers."Order"
         WHERE Total >= :minTotal)
    &sql(OPEN OrderCursor)
    For {
        &sql(FETCH OrderCursor)
        If SQLCODE '= 0 Quit
        Write "Order #", id, " | Total: ", amt, !
    }
    &sql(CLOSE OrderCursor)
}

}