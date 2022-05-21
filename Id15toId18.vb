'
'Salesforce15桁IDを得て、18桁IDを返す
'
Public Function id15to18(id15 As String) As String
    
    If Len(id15) <> 15 Then
        id15to18 = id15
        Exit Function
    End If

    Dim i As Integer
    Dim j As Integer
    Dim chr1 As String
    Dim flags As Integer
    Dim buf1 As Integer
    Dim suffix As String
    
    suffix = ""
    For i = 0 To 2
        flags = 0
        
        For j = 0 To 4
            chr1 = Mid(id15, (i * 5 + j + 1), 1)
            If (Asc(chr1) >= Asc("A") And Asc(chr1) <= Asc("Z")) Then
                Select Case j
                    Case 0:
                        buf1 = 1
                    Case 1:
                        buf1 = 2
                    Case 2:
                        buf1 = 4
                    Case 3:
                        buf1 = 8
                    Case 4:
                        buf1 = 16
                End Select
                flags = flags + buf1
            End If
        Next
        
        suffix = suffix & Mid("ABCDEFGHIJKLMNOPQRSTUVWXYZ012345", (flags + 1), 1)
    Next
    
    id15to18 = id15 & suffix
End Function
