Class Flowers.OrderItem Extends (%Persistent)
{
Relationship Order As Flowers.Order [ Cardinality = one, Inverse = Items ];
Property Bouquet As Flowers.Bouquet;
Property Quantity As %Integer(MINVAL=1, MAXVAL=99);
Property Note As %Stream.GlobalCharacter;
Property Subtotal As %Numeric;
}