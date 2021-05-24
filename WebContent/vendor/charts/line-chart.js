var ctx = document.getElementById('annualProjectOverview').getContext('2d');
var project = document.getElementById('project').value;
var projectCreatedOn = document.getElementById('projectCreatedOn').value;
var totalProjectHours = document.getElementById('monthlyProjectHours').value;
var now = new Date();

var axixX = [];
var axixY = totalProjectHours; //document.getElementById('barX').value;

var getMonths = function(startDate, endDate){
    var resultList = [];
    var date = new Date(startDate);
    var endDate = now;
    var monthNameList = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

    while (date <= endDate)
    {
        var stringDate = monthNameList[date.getMonth()] + " " + date.getFullYear();
        var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
        var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
        
        resultList.push({
            str:stringDate,
            first:firstDay,
            last:lastDay,
        });
        date.setMonth(date.getMonth() + 1);
    }
    
    return resultList;
};
var mos = getMonths(projectCreatedOn);

for (var m in mos) {axixX.push(mos[m].str);}


var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
		  labels: axixX,
			datasets: [
			{
				label: project,
			    data: axixY.split(','),
				borderColor: '#0066cb',
			    backgroundColor: '#0066cb',
	    	}],
	  },
	  options: {
	    responsive: true,
	    plugins: {
	      legend: {
	        position: 'top',
	      },
	      title: {
	        display: true,
	      }
	    }
	  },
	});
