Class Flowers.Tests.CustomerTest Extends %RegisteredObject
{

Method TestCreateAndDelete()
{
    Set c = ##class(Flowers.Customer).%New()
    Set c.Name = "Test Customer"
    Set c.Phone = "123-456-7890"
    Set c.Email = "testcust@example.com"
    Set sc = c.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set id = c.%Id()
    If id="" { Throw ##class(%Exception.General).%New("Saved object must have Id") }

    Set sc = ##class(Flowers.Customer).%DeleteId(id)
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
    If ##class(Flowers.Customer).%ExistsId(id) { Throw ##class(%Exception.General).%New("Object must not exist after delete") }
}

Method TestUniqueEmail()
{
    Set a = ##class(Flowers.Customer).%New()
    Set a.Name = "AAA"
    Set a.Email = "uniqemail@example.com"
    Set sc = a.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set b = ##class(Flowers.Customer).%New()
    Set b.Name = "BBB"
    Set b.Email = "uniqemail@example.com"
    Set sc = b.%Save()
    // Очікуємо помилку — дублікат Email
    If $$$ISOK(sc) {
        Do ##class(Flowers.Customer).%DeleteId(b.%Id())
        Do ##class(Flowers.Customer).%DeleteId(a.%Id())
        Throw ##class(%Exception.General).%New("Duplicate Email should fail")
    }

    Do ##class(Flowers.Customer).%DeleteId(a.%Id())
}

Method TestValidationAndDeleteWithOrders()
{
    Set c = ##class(Flowers.Customer).%New()
    Set c.Name = "NoEmail"
    Set sc = c.%Save()
    // Очікуємо помилку — Email required
    If $$$ISOK(sc) {
        Do ##class(Flowers.Customer).%DeleteId(c.%Id())
        Throw ##class(%Exception.General).%New("Missing Email should fail")
    }

    Set c.Email = "noemailcust@example.com"
    Set c.Name = "AB"
    Set sc = c.%Save()
    // Очікуємо помилку — Name занадто коротке
    If $$$ISOK(sc) {
        Do ##class(Flowers.Customer).%DeleteId(c.%Id())
        Throw ##class(%Exception.General).%New("Name shorter than MIN should fail")
    }

    Set c.Name = "Valid Customer"
    Set sc = c.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set emp = ##class(Flowers.Employee).%New()
    Set emp.Name = "TempEmp"
    Set emp.Position = "Florist"
    Set sc = emp.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set ord = ##class(Flowers.Order).%New()
    Set ord.OrderId = $Random(100000) + 50000
    Set ord.OrderDate = $Piece($HOROLOG,",",1)
    Set ord.Total = 10
    Set ord.Customer = c
    Set ord.HandledBy = emp
    Set sc = ord.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    // Спроба видалити Customer з Orders — має бути помилка
    Set sc = ##class(Flowers.Customer).%DeleteId(c.%Id())
    If $$$ISOK(sc) {
        Throw ##class(%Exception.General).%New("Customer with Orders should not be deleted directly")
    }

    // Очистка
    Do ##class(Flowers.Order).%DeleteId(ord.%Id())
    Do ##class(Flowers.Employee).%DeleteId(emp.%Id())
    Set sc = ##class(Flowers.Customer).%DeleteId(c.%Id())
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
}

}
