Class Flowers.Tests.FlowerTest Extends %RegisteredObject
{

Method TestCreateAndDelete()
{
    Set f = ##class(Flowers.Flower).%New()
    Set f.Name = "Test Rose"
    Set f.Color = "Red"
    Set f.FreshDays = 10
    Set f.Sku = "TEST-ROSE-001"
    Set f.Price = 35.50
    Set sc = f.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set id = f.%Id()
    If id="" { Throw ##class(%Exception.General).%New("Saved object must have Id") }

    Set sc = ##class(Flowers.Flower).%DeleteId(id)
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
    If ##class(Flowers.Flower).%ExistsId(id) { Throw ##class(%Exception.General).%New("Object must not exist after delete") }
}

Method TestUniqueSku()
{
    Set a = ##class(Flowers.Flower).%New()
    Set a.Name = "AAA"
    Set a.Color = "White"
    Set a.FreshDays = 5
    Set a.Sku = "UNQ-SKU-001"
    Set a.Price = 10
    Set sc = a.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }

    Set b = ##class(Flowers.Flower).%New()
    Set b.Name = "BBB"
    Set b.Color = "Blue"
    Set b.FreshDays = 6
    Set b.Sku = "UNQ-SKU-001"
    Set b.Price = 12
    Set sc = b.%Save()
    If $$$ISOK(sc) {
        Do ##class(Flowers.Flower).%DeleteId(b.%Id())
        Do ##class(Flowers.Flower).%DeleteId(a.%Id())
        Throw ##class(%Exception.General).%New("Duplicate SKU should fail")
    }

    Do ##class(Flowers.Flower).%DeleteId(a.%Id())
}

Method TestBasicValidation()
{
    Set f = ##class(Flowers.Flower).%New()
    Set f.Name = "Valid Name"
    Set f.Color = "Pink"
    Set f.FreshDays = 5
    Set f.Sku = "VAL-SKU-001"
    Set f.Price = 0.01
    Set sc = f.%Save()
    If $$$ISOK(sc) {
        Do ##class(Flowers.Flower).%DeleteId(f.%Id())
        Throw ##class(%Exception.General).%New("Price too low should fail")
    }

    Set f.FreshDays = 0
    Set sc = f.%Save()
    If $$$ISOK(sc) {
        Do ##class(Flowers.Flower).%DeleteId(f.%Id())
        Throw ##class(%Exception.General).%New("FreshDays < MIN should fail")
    }

    Set f.FreshDays = 5
    Set f.Price = 5.00
    Set sc = f.%Save()
    If $$$ISERR(sc) { Throw ##class(%Exception.StatusException).CreateFromStatus(sc) }
    Do ##class(Flowers.Flower).%DeleteId(f.%Id())
}

}
