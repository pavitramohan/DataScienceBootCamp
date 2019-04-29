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
  var inputElement = d3.select("#datetime");

  // Get the value property of the input element
  var inputValue = inputElement.property("value");

  console.log(inputValue);

  var filteredValues = tableData.filter(data1 => data1.datetime === inputValue);

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
