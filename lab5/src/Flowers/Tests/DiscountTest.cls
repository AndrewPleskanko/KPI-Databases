Class Flowers.Tests.DiscountTest Extends %RegisteredObject
{

Method TestCreateAndDelete()
{
    Set d = ##class(Flowers.Discount).%New()
    Set d.Code = "TEST10-DEL"
    Set d.Percent = 10
    Set d.Expiry = $ZDATEH("2025-12-31",3)
    Set sc = d.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
    
    Set id = d.%Id()
    If id="" { Throw ##class(%Exception.General).%New("Saved object must have Id") }
    
    Set sc = ##class(Flowers.Discount).%DeleteId(id)
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
}

Method TestUniqueCode()
{
    Set a = ##class(Flowers.Discount).%New()
    Set a.Code = "UNQ-DISC-001"
    Set a.Percent = 15
    Set a.Expiry = $ZDATEH("2025-06-30",3)
    Set sc = a.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set b = ##class(Flowers.Discount).%New()
    Set b.Code = "UNQ-DISC-001"
    Set b.Percent = 20
    Set b.Expiry = $ZDATEH("2025-07-31",3)
    Set sc = b.%Save()
    // Очікуємо помилку — дублікат Code
    If $$$ISOK(sc) {
        Do ##class(Flowers.Discount).%DeleteId(b.%Id())
        Do ##class(Flowers.Discount).%DeleteId(a.%Id())
        Throw ##class(%Exception.General).%New("Duplicate Code should fail")
    }

    Do ##class(Flowers.Discount).%DeleteId(a.%Id())
}

Method TestPercentAndExpiryValidation()
{
    // Percent занадто малий (0)
    Set d = ##class(Flowers.Discount).%New()
    Set d.Code = "P_LOW_TEST"
    Set d.Percent = 0
    Set d.Expiry = $ZDATEH("2025-12-31",3)
    Set sc = d.%Save()
    If $$$ISOK(sc) {
        Do ##class(Flowers.Discount).%DeleteId(d.%Id())
        Throw ##class(%Exception.General).%New("Percent < MIN should fail")
    }

    // Мінімум = 1
    Set d.Percent = 1
    Set d.Code = "P_MIN_TEST"
    Set sc = d.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
    Do ##class(Flowers.Discount).%DeleteId(d.%Id())

    // Максимум = 100
    Set d2 = ##class(Flowers.Discount).%New()
    Set d2.Code = "P_MAX_TEST"
    Set d2.Percent = 100
    Set d2.Expiry = $ZDATEH("2025-12-31",3)
    Set sc = d2.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
    Do ##class(Flowers.Discount).%DeleteId(d2.%Id())

    // Вище MAX — помилка
    Set d3 = ##class(Flowers.Discount).%New()
    Set d3.Code = "P_TOO_HIGH_TEST"
    Set d3.Percent = 101
    Set d3.Expiry = $ZDATEH("2025-12-31",3)
    Set sc = d3.%Save()
    If $$$ISOK(sc) {
        Do ##class(Flowers.Discount).%DeleteId(d3.%Id())
        Throw ##class(%Exception.General).%New("Percent > MAX should fail")
    }
}

}
