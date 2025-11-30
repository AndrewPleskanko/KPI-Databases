Class Flowers.Discount Extends (%Persistent)
{
Property Code As %String;
Property Percent As %Integer(MINVAL=1, MAXVAL=100);
Property Expiry As %Date;

Index CodeIndex On Code [ Unique ];
}
