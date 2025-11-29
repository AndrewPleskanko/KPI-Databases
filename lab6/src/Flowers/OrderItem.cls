Class Flowers.OrderItem Extends (%Persistent)
{
Relationship Order As Flowers.Order [ Cardinality = one, Inverse = Items ];
Property Bouquet As Flowers.Bouquet;
Property Quantity As %Integer(MINVAL=1, MAXVAL=99);
Property Note As %Stream.GlobalCharacter;
Property Subtotal As %Numeric;
Query ItemsWithDetails() As %SQLQuery
{
    SELECT oi.ID, oi."Order"->OrderId AS OrderId, oi.Bouquet->Style AS BouquetStyle, oi.Quantity, oi.Subtotal
    FROM Flowers.OrderItem oi
}
}
