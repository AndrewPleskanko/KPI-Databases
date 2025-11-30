Class Flowers.Utils.ClientTest
{

ClassMethod RESTGetAll() As %Status
{
    Write "=== REST GET /flowers ===",!
    Set req = ##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773
    Set req.Username="SuperUser", req.Password="SuperUser"
    Do req.Get("/api/flowers/flowers")
    Write req.HttpResponse.Data.Read(),!
    Return $$$OK
}

ClassMethod RESTCreate(name As %String = "Test Rose", color As %String = "Red", price As %Numeric = 25, sku As %String = "") As %Status
{
    Write "=== REST POST /flowers ===",!
    If sku="" Set sku = "FL-"_$R(9999)
    Set req = ##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773, req.ContentType="application/json"
    Set req.Username="SuperUser", req.Password="SuperUser"
    Set json = {"name":(name),"color":(color),"price":(price),"sku":(sku)}
    Do req.EntityBody.Write(json.%ToJSON())
    Do req.Post("/api/flowers/flowers")
    Write req.HttpResponse.Data.Read(),!
    Return $$$OK
}

ClassMethod RESTDelete(id As %Integer) As %Status
{
    Write "=== REST DELETE /flowers/"_id_" ===",!
    Set req = ##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773
    Set req.Username="SuperUser", req.Password="SuperUser"
    Do req.Delete("/api/flowers/flowers/"_id)
    Write req.HttpResponse.Data.Read(),!
    Return $$$OK
}

ClassMethod SOAPGetAll() As %Status
{
    Write "=== SOAP GetAllFlowers ===",!
    Set req = ##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773, req.ContentType="text/xml"
    Set req.Username="SuperUser", req.Password="SuperUser"
    Do req.SetHeader("SOAPAction","http://flowers.example.com/GetAllFlowers")
    Set env = "<?xml version=""1.0""?><soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""><soap:Body><GetAllFlowers xmlns=""http://flowers.example.com""/></soap:Body></soap:Envelope>"
    Do req.EntityBody.Write(env)
    Do req.Post("/csp/user/Flowers.API.SOAP.cls")
    Write req.HttpResponse.Data.Read(),!
    Return $$$OK
}

ClassMethod SOAPCreate(name As %String = "SOAP Rose", color As %String = "Pink", price As %Numeric = 30, sku As %String = "") As %Status
{
    Write "=== SOAP CreateFlower ===",!
    If sku="" Set sku = "FL-S"_$R(9999)
    Set req = ##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773, req.ContentType="text/xml"
    Set req.Username="SuperUser", req.Password="SuperUser"
    Do req.SetHeader("SOAPAction","http://flowers.example.com/CreateFlower")
    Set env = "<?xml version=""1.0""?><soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""><soap:Body><CreateFlower xmlns=""http://flowers.example.com""><name>"_name_"</name><color>"_color_"</color><price>"_price_"</price><sku>"_sku_"</sku></CreateFlower></soap:Body></soap:Envelope>"
    Do req.EntityBody.Write(env)
    Do req.Post("/csp/user/Flowers.API.SOAP.cls")
    Write req.HttpResponse.Data.Read(),!
    Return $$$OK
}

ClassMethod SOAPDelete(id As %Integer) As %Status
{
    Write "=== SOAP DeleteFlower ===",!
    Set req = ##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773, req.ContentType="text/xml"
    Set req.Username="SuperUser", req.Password="SuperUser"
    Do req.SetHeader("SOAPAction","http://flowers.example.com/DeleteFlower")
    Set env = "<?xml version=""1.0""?><soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""><soap:Body><DeleteFlower xmlns=""http://flowers.example.com""><id>"_id_"</id></DeleteFlower></soap:Body></soap:Envelope>"
    Do req.EntityBody.Write(env)
    Do req.Post("/csp/user/Flowers.API.SOAP.cls")
    Write req.HttpResponse.Data.Read(),!
    Return $$$OK
}

ClassMethod RunAll() As %Status
{
    Do ..RESTGetAll()
    Do ..RESTCreate()
    Do ..SOAPGetAll()
    Do ..SOAPCreate()
    Return $$$OK
}

}
