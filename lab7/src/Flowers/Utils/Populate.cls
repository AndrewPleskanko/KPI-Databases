Class Flowers.Utils.Populate
{

ClassMethod Run() As %Status
{
    Set f1 = ##class(Flowers.Flower).%New()
    Set f1.Name = "Red Rose", f1.Color = "Red", f1.FreshDays = 10, f1.Sku = "FL-001", f1.Price = 35
    Do f1.%Save()

    Set f2 = ##class(Flowers.Flower).%New()
    Set f2.Name = "White Lily", f2.Color = "White", f2.FreshDays = 7, f2.Sku = "FL-002", f2.Price = 50
    Do f2.%Save()

    Set d1 = ##class(Flowers.Decoration).%New()
    Set d1.Name = "Paper Wrap", d1.Color = "Brown", d1.FreshDays = 0, d1.Material = "Paper", d1.Reusable = 0
    Do d1.%Save()

    Set d2 = ##class(Flowers.Decoration).%New()
    Set d2.Name = "Silk Ribbon", d2.Color = "Pink", d2.FreshDays = 0, d2.Material = "Silk", d2.Reusable = 1
    Do d2.%Save()

    Set b1 = ##class(Flowers.Bouquet).%New()
    Set b1.Style = "Romantic", b1.Price = 120
    Do b1.Flowers.Insert(f1), b1.Flowers.Insert(f2), b1.Decorations.Insert(d2)
    Do b1.%Save()

    Set b2 = ##class(Flowers.Bouquet).%New()
    Set b2.Style = "Classic", b2.Price = 80
    Do b2.Flowers.Insert(f2), b2.Decorations.Insert(d1)
    Do b2.%Save()

    Set c1 = ##class(Flowers.Customer).%New()
    Set c1.Name = "Alice Johnson", c1.Phone = "123-456", c1.Email = "alice@mail.com"
    Do c1.%Save()

    Set c2 = ##class(Flowers.Customer).%New()
    Set c2.Name = "Bob Smith", c2.Phone = "555-777", c2.Email = "bob@mail.com"
    Do c2.%Save()

    Set e1 = ##class(Flowers.Employee).%New()
    Set e1.Name = "Emma Carter", e1.Position = "Florist"
    Do e1.%Save()

    Set e2 = ##class(Flowers.Employee).%New()
    Set e2.Name = "Mark Wilson", e2.Position = "Senior Florist", e2.Supervisor = e1
    Do e2.%Save()

    Set o1 = ##class(Flowers.Order).%New()
    Set o1.OrderId = 1001, o1.OrderDate = $Horolog, o1.Customer = c1, o1.HandledBy = e1, o1.Total = 200
    Do o1.%Save()

    Set o2 = ##class(Flowers.Order).%New()
    Set o2.OrderId = 1002, o2.OrderDate = $Horolog, o2.Customer = c2, o2.HandledBy = e2, o2.Total = 150
    Do o2.%Save()

    Set oi1 = ##class(Flowers.OrderItem).%New()
    Set oi1.Order = o1, oi1.Bouquet = b1, oi1.Quantity = 1, oi1.Subtotal = 120
    Do oi1.%Save()

    Set oi2 = ##class(Flowers.OrderItem).%New()
    Set oi2.Order = o2, oi2.Bouquet = b2, oi2.Quantity = 2, oi2.Subtotal = 160
    Do oi2.%Save()

    Set dis1 = ##class(Flowers.Discount).%New()
    Set dis1.Code = "LOVE10", dis1.Percent = 10, dis1.Expiry = $ZDATEH("2025-05-10", 3)
    Do dis1.%Save()

    Set dis2 = ##class(Flowers.Discount).%New()
    Set dis2.Code = "SPRING20", dis2.Percent = 20, dis2.Expiry = $ZDATEH("2025-05-30", 3)
    Do dis2.%Save()

    Write "Successfully created 18 objects!"
    Return $$$OK
}

}
