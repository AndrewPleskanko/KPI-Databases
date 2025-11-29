Class Flowers.Flower Extends Flowers.Plant
{

/// Артикул (Унікальний код)
Property Sku As %String [ Required ];

/// Ціна
Property Price As %Numeric;

/// Країна походження
Property OriginCountry As %String;

/// Unique index on Sku (не можна IdKey бо наслідує Plant)
Index SkuIdx On Sku [ Unique ];

/// ✅ ВИМОГА: Query with arguments
Query FindByCountry(country As %String) As %SQLQuery
{
    SELECT Name, Price, Sku FROM Flowers.Flower 
    WHERE OriginCountry = :country
}

}
