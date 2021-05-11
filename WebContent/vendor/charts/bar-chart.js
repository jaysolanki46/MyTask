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
				label: 'Progress',
				data: barYListProgress.split(','),
				backgroundColor: '#ff6384',
		    },
			{
				label: 'Hours Spent',
				data: barYListHoursSpent.split(','),
				backgroundColor: '#36a2eb',
		    }
		],
	  },
	  options: {
		    plugins: {
			      title: {
			        display: true,
			        text: 'Member Tasks'
			      },
			    },
			    responsive: false,
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
