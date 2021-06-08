var ctx = document.getElementById('teamMember').getContext('2d');
var barX = document.getElementById('barX').value;
var barYListProgress = document.getElementById('barYListProgress').value;
var barYListHoursSpent = document.getElementById('barYListHoursSpent').value;

var myBarChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
		  labels: barX.split(','),
	      datasets: [
			{
				label: 'Progress %',
				data: barYListProgress.split(','),
				backgroundColor: '#b81b44',
		    },
			{
				label: 'Hours Spent',
				data: barYListHoursSpent.split(','),
				backgroundColor: '#0066cb',
		    }
		],
	  },
	  options: {
		    plugins: {
			      title: {
			        display: true,
			      },
			    },
			    responsive: true,
			 },
			scales: {
		      x: {
		        stacked: true,
		      },
		      y: {
		        stacked: true
		      }
		    }
	});
