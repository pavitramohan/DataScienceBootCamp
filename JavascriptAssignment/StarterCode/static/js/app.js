// from data.js
var tableData = data;

// YOUR CODE HERE!

var ufoTable = d3.select("tbody");
tableData.forEach(data1 => {   
    var row = ufoTable.append("tr");
    Object.entries(data1).forEach(([key, value]) => {
        var cell = row.append("td");
        cell.text(value);
    });
});


var submit = d3.select("#filter-btn");

submit.on("click", function() {

  // Prevent the page from refreshing
  d3.event.preventDefault();

  // Select the input element and get the raw HTML node
  var datetimeValue = d3.select("#datetime").property("value");
  var cityValue = d3.select("#city").property("value");
  var stateValue = d3.select("#state").property("value");
  var countryValue = d3.select("#country").property("value");
  var shapeValue = d3.select("#shape").property("value");

  var filteredValues = tableData;
  
  if(datetimeValue)
    filteredValues = filteredValues.filter(data1 => data1.datetime === datetimeValue);

  if(cityValue)
    filteredValues = filteredValues.filter(data1 => data1.city === cityValue);

  if(stateValue)
    filteredValues = filteredValues.filter(data1 => data1.state === stateValue);

  if(countryValue)
    filteredValues = filteredValues.filter(data1 => data1.country === countryValue);

  if(shapeValue)
    filteredValues = filteredValues.filter(data1 => data1.shape === shapeValue);

  var tbody = d3.select("tbody");
  var rows = tbody.selectAll("tr").remove();
  
  filteredValues.forEach(data1 => {   
      var row = tbody.append("tr");
      Object.entries(data1).forEach(([key, value]) => {
          var cell = row.append("td");
          cell.text(value);
      });
  });
  


});
