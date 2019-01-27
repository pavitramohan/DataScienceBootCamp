Attribute VB_Name = "Module1"
Sub alphabetical_testing(ws As Worksheet)

    'Get the last of the Excel sheet
    lastrow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
    
    'Declare summaryRow as integer
    Dim summaryRow As Integer
    
    'Declare YearOpenValue as Integer
    Dim yearOpenValue As Long
    
    'Declare greatestPercent,lowestPercent as Integer
    Dim greatestPercent, lowestPercent As Double
    
    Dim initialized As Boolean
    
    initialized = False
    
    'Initialize headers for new rows
    ws.Range("I1") = "Ticker"
    ws.Range("J1") = "Yearly Change"
    ws.Range("K1") = "Percent Change"
    ws.Range("L1") = "Total Stock Volume"
    
    ws.Range("P1") = "Ticker"
    ws.Range("Q1") = "Value"
    
    ws.Range("O2") = "Greatest % Increase"
    ws.Range("O3") = "Greatest % Decrease"
    ws.Range("O4") = "Greatest Total Volume"
         
    'Initialize summaryRow as 2
    summaryRow = 2
    
    'Initialize YearOpenValue with first ticker open value
    yearOpenValue = ws.Cells(2, 3)
    
    'Loop through all the ticker records
    For i = 2 To lastrow
    
      'Add the tickerCount with Stock volume of cuurect record
      tickerCount = tickerCount + ws.Cells(i, 7)
     
      'compare if the current ticker symbol not equal next row's ticker symbol
      If (ws.Cells(i + 1, 1) <> ws.Cells(i, 1)) Then
        
        'Fill the summary row with ticker symbol
        ws.Cells(summaryRow, 9) = ws.Cells(i, 1)
        ws.Cells(summaryRow, 12) = tickerCount
        
        'Find the change in the Ticker Open & close
        ws.Cells(summaryRow, 10) = ws.Cells(i, 6) - yearOpenValue
        If (ws.Cells(summaryRow, 10) > 0) Then
           ws.Cells(summaryRow, 10).Interior.ColorIndex = 4
        Else
            ws.Cells(summaryRow, 10).Interior.ColorIndex = 3
        End If
            
         
        
        'Find the Percent change in ticker open & close
        If (yearOpenValue = 0) Then
           ws.Cells(summaryRow, 11) = Format(0, "Percent")
        Else
            ws.Cells(summaryRow, 11) = Format(ws.Cells(summaryRow, 10) / yearOpenValue, "Percent")
        End If
        
       
        
        If (initialized = False) Then
            'Initialize tickerCount to 0
            greatestCount = tickerCount
            greatestPercent = ws.Cells(summaryRow, 11)
            lowestPercent = ws.Cells(summaryRow, 11)
            initialized = True
        End If
    
        
        'store the greatest percent incresed
        If (ws.Cells(summaryRow, 11) > greatestPercent) Then
            greatestPercent = ws.Cells(summaryRow, 11)
            ws.Range("p2") = ws.Cells(i, 1)
            ws.Range("q2") = Format(greatestPercent, "Percent")
        End If
        
        'store the lowest percent incresed
        If (ws.Cells(summaryRow, 11) < lowestPercent) Then
            lowestPercent = ws.Cells(summaryRow, 11)
            ws.Range("p3") = ws.Cells(i, 1)
            ws.Range("q3") = Format(lowestPercent, "Percent")
        End If
        
        'store the greatest ticker count
        If (tickerCount > greatestCount) Then
            greatestCount = tickerCount
            ws.Range("p4") = ws.Cells(i, 1)
            ws.Range("q4") = greatestCount
        End If
        
        
        'Reset the Ticker Count
        tickerCount = 0
        
        'Increment the summaryRow by 1
        summaryRow = summaryRow + 1
        
        
        'Assign the Year Open Value of Next Ticker
        yearOpenValue = ws.Cells(i + 1, 3)
      End If
    
    Next i
End Sub


Sub allWorksheetsAlphabeticalTesting()

  Dim ws As Worksheet
  
  For Each ws In Worksheets
  
    Call alphabetical_testing(ws)
  
  Next ws

End Sub
