Class Flowers.Tests.TestRunner
{

ClassMethod RunAll() As %Status
{
    Set list = $ListBuild(
        "Flowers.Tests.FlowerTest",
        "Flowers.Tests.CustomerTest",
        "Flowers.Tests.DiscountTest",
        "Flowers.Tests.OrderTest"
    )
    
    Set totalPassed = 0
    Set totalFailed = 0

    For i=1:1:$ListLength(list) {
        Set cls = $ListGet(list,i)
        If '##class(%Dictionary.CompiledClass).%ExistsId(cls) {
            Write !, "Class not found, skipping: ", cls
            Continue
        }
        Write !, "=== Running tests for: ", cls, " ===", !
        
        Set methods = ""
        Set classdef = ##class(%Dictionary.CompiledClass).%OpenId(cls)
        If classdef '= "" {
            For j=1:1:classdef.Methods.Count() {
                Set methoddef = classdef.Methods.GetAt(j)
                Set methodName = methoddef.Name
                If $Extract(methodName, 1, 4) = "Test" {
                    Set methods = methods _ $ListBuild(methodName)
                }
            }
        }
        
        Set testObj = $ClassMethod(cls, "%New")
        Set passed = 0
        Set failed = 0
        
        For j=1:1:$ListLength(methods) {
            Set method = $ListGet(methods, j)
            Write "  Running ", method, "... "
            Try {
                Do $Method(testObj, method)
                Write "PASSED", !
                Set passed = passed + 1
            } Catch ex {
                Write "FAILED: ", ex.DisplayString(), !
                Set failed = failed + 1
            }
        }
        
        Write "  Results: ", passed, " passed, ", failed, " failed", !
        Set totalPassed = totalPassed + passed
        Set totalFailed = totalFailed + failed
    }

    Write !, "====================================", !
    Write "Total: ", totalPassed, " passed, ", totalFailed, " failed", !
    
    If totalFailed > 0 {
        Quit $$$ERROR($$$GeneralError, "Some tests failed")
    }
    Quit $$$OK
}

}
