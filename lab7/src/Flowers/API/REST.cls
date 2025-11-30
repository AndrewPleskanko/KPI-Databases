Class Flowers.API.REST Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/flowers" Method="GET" Call="GetAll"/>
    <Route Url="/flowers/:id" Method="GET" Call="GetOne"/>
    <Route Url="/flowers" Method="POST" Call="Create"/>
    <Route Url="/flowers/:id" Method="PUT" Call="Update"/>
    <Route Url="/flowers/:id" Method="DELETE" Call="Delete"/>
</Routes>
}

ClassMethod GetAll() As %Status
{
    Set %response.ContentType = "application/json"
    Set arr = [], rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Flowers.Flower")
    While rs.%Next() {
        Do arr.%Push({"id":(rs.ID),"name":(rs.Name),"color":(rs.Color),"price":(rs.Price),"sku":(rs.Sku)})
    }
    Write arr.%ToJSON()
    Return $$$OK
}

ClassMethod GetOne(id As %String) As %Status
{
    Set %response.ContentType = "application/json"
    Set obj = ##class(Flowers.Flower).%OpenId(id)
    If obj="" { Set %response.Status="404" Write {"error":"Not found"} Return $$$OK }
    Write {"id":(obj.%Id()),"name":(obj.Name),"color":(obj.Color),"price":(obj.Price),"sku":(obj.Sku)}
    Return $$$OK
}

ClassMethod Create() As %Status
{
    Set %response.ContentType = "application/json"
    Set json = {}.%FromJSON(%request.Content)
    Set obj = ##class(Flowers.Flower).%New()
    Set obj.Name=json.name, obj.Color=json.color, obj.Price=json.price, obj.Sku=json.sku
    Set sc = obj.%Save()
    If $$$ISERR(sc) { Set %response.Status="400" Write {"error":"Save failed"} Return $$$OK }
    Set %response.Status = "201"
    Write {"id":(obj.%Id()),"message":"Created"}
    Return $$$OK
}

ClassMethod Update(id As %String) As %Status
{
    Set %response.ContentType = "application/json"
    Set obj = ##class(Flowers.Flower).%OpenId(id)
    If obj="" { Set %response.Status="404" Write {"error":"Not found"} Return $$$OK }
    Set json = {}.%FromJSON(%request.Content)
    If json.%IsDefined("name") Set obj.Name=json.name
    If json.%IsDefined("color") Set obj.Color=json.color
    If json.%IsDefined("price") Set obj.Price=json.price
    If json.%IsDefined("sku") Set obj.Sku=json.sku
    Do obj.%Save()
    Write {"message":"Updated"}
    Return $$$OK
}

ClassMethod Delete(id As %String) As %Status
{
    Set %response.ContentType = "application/json"
    Set sc = ##class(Flowers.Flower).%DeleteId(id)
    If $$$ISERR(sc) { Set %response.Status="404" Write {"error":"Not found"} Return $$$OK }
    Write {"message":"Deleted"}
    Return $$$OK
}

}
