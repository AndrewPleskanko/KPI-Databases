Class Flowers.Plant Extends (%Persistent, %XML.Adaptor)
{
Property Name As %String(MINLEN=2, MAXLEN=100);
Property Color As %String;
Property FreshDays As %Integer(MINVAL=1, MAXVAL=30);
Property Photo As %Stream.GlobalBinary;
}
