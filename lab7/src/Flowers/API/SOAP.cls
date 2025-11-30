Class Flowers.API.SOAP Extends %SOAP.WebService
{

Parameter SERVICENAME = "FlowerService";
Parameter NAMESPACE = "http://flowers.example.com";

Method GetAllFlowers() As %String [ WebMethod ]
{
    Set result = "", rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT ID,Name,Color,Price,Sku FROM Flowers.Flower")
    While rs.%Next() { Set result = result _ rs.ID _ "|" _ rs.Name _ "|" _ rs.Color _ "|" _ rs.Price _ ";" }
    Return result
}

Method GetFlower(id As %Integer) As %String [ WebMethod ]
{
    Set obj = ##class(Flowers.Flower).%OpenId(id)
    If obj="" Return "Not found"
    Return obj.Name _ "|" _ obj.Color _ "|" _ obj.Price _ "|" _ obj.Sku
}

Method CreateFlower(name As %String, color As %String, price As %Numeric, sku As %String) As %String [ WebMethod ]
{
    Set obj = ##class(Flowers.Flower).%New()
    Set obj.Name=name, obj.Color=color, obj.Price=price, obj.Sku=sku
    Set sc = obj.%Save()
    If $$$ISERR(sc) Return "Error: " _ $System.Status.GetErrorText(sc)
    Return "Created ID: " _ obj.%Id()
}

Method UpdateFlower(id As %Integer, name As %String, color As %String, price As %Numeric) As %String [ WebMethod ]
{
    Set obj = ##class(Flowers.Flower).%OpenId(id)
    If obj="" Return "Not found"
    If name'="" Set obj.Name=name
    If color'="" Set obj.Color=color
    If price'="" Set obj.Price=price
    Do obj.%Save()
    Return "Updated ID: " _ id
}

Method DeleteFlower(id As %Integer) As %String [ WebMethod ]
{
    Set sc = ##class(Flowers.Flower).%DeleteId(id)
    If $$$ISERR(sc) Return "Error"
    Return "Deleted ID: " _ id
}

}
