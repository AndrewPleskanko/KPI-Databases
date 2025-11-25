Class Flowers.Flower Extends Flowers.Plant
{
Property Price As %Numeric(MINVAL=0.5, MAXVAL=500);
Property OriginCountry As %String;
Property Sku As %String;

Index SkuIndex On Sku [ Unique ];
}
