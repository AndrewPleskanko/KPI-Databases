Class Flowers.Bouquet Extends (%Persistent)
{
Property Style As %String;
Property Message As %Stream.GlobalCharacter;
Property Flowers As list Of Flowers.Flower;
Property Decorations As list Of Flowers.Decoration;
Property Price As %Numeric;
}