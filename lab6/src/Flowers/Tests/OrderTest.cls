Class Flowers.Tests.OrderTest Extends %RegisteredObject
{

Method TestOrderTotalWithTax()
{
    Set o = ##class(Flowers.Order).%New()
    Set o.OrderId = $Random(100000) + 90000
    Set o.OrderDate = $Piece($HOROLOG,",",1)
    Set o.Total = 100
    Set sc = o.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    // Перевіряємо розрахунок TotalWithTax (1.20)
    If o.TotalWithTax '= 120 {
        Do ##class(Flowers.Order).%DeleteId(o.%Id())
        Throw ##class(%Exception.General).%New("TotalWithTax should be 120, got: " _ o.TotalWithTax)
    }

    Do ##class(Flowers.Order).%DeleteId(o.%Id())
}

Method TestDeleteCustomerRestriction()
{
    Set c = ##class(Flowers.Customer).%New()
    Set c.Name = "RestrictTest"
    Set c.Email = "rtest" _ $Random(100000) _ "@example.com"
    Set sc = c.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set emp = ##class(Flowers.Employee).%New()
    Set emp.Name = "EmpTest"
    Set emp.Position = "Florist"
    Set sc = emp.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set ord = ##class(Flowers.Order).%New()
    Set ord.OrderId = $Random(100000) + 90000
    Set ord.OrderDate = $Piece($HOROLOG,",",1)
    Set ord.Total = 50
    Set ord.Customer = c
    Set ord.HandledBy = emp
    Set sc = ord.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    // Спроба видалити Customer з Orders — має бути помилка
    Set sc = ##class(Flowers.Customer).%DeleteId(c.%Id())
    If $$$ISOK(sc) {
        Throw ##class(%Exception.General).%New("Customer with Orders should be restricted from delete")
    }

    // Очистка
    Do ##class(Flowers.Order).%DeleteId(ord.%Id())
    Do ##class(Flowers.Employee).%DeleteId(emp.%Id())
    Do ##class(Flowers.Customer).%DeleteId(c.%Id())
}

}
