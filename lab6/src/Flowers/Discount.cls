Class Flowers.Discount Extends (%Persistent)
{
Property Code As %String;
Property Percent As %Integer(MINVAL=1, MAXVAL=100);
Property Expiry As %Date;

Index CodeIndex On Code [ IdKey ];

Trigger OnInsert [ Event = INSERT, Foreach = row/object, Time = AFTER ]
{
    Set ^DiscountLog($I(^DiscountLog)) = $LB("INSERT", {Code}, {Percent}, $ZDT($H,3))
}

Query AllDiscounts() As %SQLQuery
{
    SELECT Code, Percent, Expiry FROM Flowers.Discount ORDER BY Percent DESC
}

ClassMethod TestTrigger() As %Status
{
    Kill ^DiscountLog
    Set d = ##class(Flowers.Discount).%New()
    Set d.Code = "TEST"_$R(1000)
    Set d.Percent = 15
    Set d.Expiry = +$H + 30
    Set sc = d.%Save()
    If $$$ISOK(sc) {
        Write "Created: ", d.Code, !
        Write "Log: ", $LTS(^DiscountLog(1)), !
    }
    Quit sc
}

}
