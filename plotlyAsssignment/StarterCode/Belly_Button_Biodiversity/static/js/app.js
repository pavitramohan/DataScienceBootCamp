function buildMetadata(sample) {

  // @TODO: Complete the following function that builds the metadata panel
  var sampleMetaDataDiv = d3.select("#sample-metadata");

  sampleMetaDataDiv.html("");
  // Use `d3.json` to fetch the metadata for a sample
    // Use d3 to select the panel with id of `#sample-metadata`
    d3.json("/metadata/" + sample).then((sampleMetaDatas) => {
      Object.entries(sampleMetaDatas).forEach(([key, value]) => {
        console.log(`${key} ${value}`); 
        sampleMetaDataDiv.append("tr").text(`${key}: ${value}`);
      });      
    });

    // BONUS: Build the Gauge Chart
    // buildGauge(data.WFREQ);
}

function buildCharts(sample) {

  // @TODO: Use `d3.json` to fetch the sample data for the plots
  d3.json("/samples/" + sample).then((sampledata) => {
    
    var trace1 = {
      x: sampledata.otu_ids,
      y: sampledata.sample_values,
      text: sampledata.otu_labels,
      mode: 'markers',
      marker: {
        color: sampledata.otu_ids,
        size: sampledata.sample_values
      }
    };
    
    var data = [trace1];
    
    var layout = {
      title: 'Bubble Chart Sample ' + sample
      //showlegend: false,
      //height: 600,
      //width: 600
    };
    
    Plotly.newPlot('bubble', data, layout);

    var otu_labels = []
      for (i in sampledata.otu_ids.slice(0,9)) {
        otu_labels.push(sample[i]);
      }

    var piedata = [{
      values: sampledata.sample_values.splice(0, 9),
      labels: sampledata.otu_ids.splice(0, 9),
      text: otu_labels,
      textinfo: 'percent',
      hoverinfo: "text + values + labels",
      type: 'pie'
    }];
    
    var pielayout = {
      height: 500,
      width: 700
    };
    
    Plotly.newPlot('pie', piedata, pielayout);

  });


    // @TODO: Build a Bubble Chart using the sample data

    // @TODO: Build a Pie Chart
    // HINT: You will need to use slice() to grab the top 10 sample_values,
    // otu_ids, and labels (10 each).
}

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
