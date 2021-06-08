var ctx = document.getElementById('multiProjectsOverview').getContext('2d');
var barX = document.getElementById('multiProjectsBarX').value;
var barYListHoursSpent = document.getElementById('multiProjectsBarYTotalHours').value;

var myBarChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
		  labels: barX.split(','),
	      datasets: [
			{
				label: 'Total Hours',
				data: barYListHoursSpent.split(','),
				backgroundColor: '#b81b44',
		    }
		],
	  },
	  options: {
		    plugins: {
				legend: {
			        position: 'top',
			      },
			      title: {
			        display: true,
			      },
			    },
			    responsive: true,
			 }
	});
