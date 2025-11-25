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
    // Коректно обробляємо порожнє/NULL значення Total
    Set t = ..Total
    If t="" Set t = 0
    Quit t * 1.20
}

Index OrderIdIndex On OrderId [ Unique ];
}