var ctx = document.getElementById('projectHours').getContext('2d');
var pieTasks = document.getElementById('pieTasks').value;
var pieTaskHours = document.getElementById('pieTaskHours').value;

var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		  labels: pieTasks.split(','),
	      datasets: [{
	      data: pieTaskHours.split(','),
	      backgroundColor: ['#5a5c69', '#36a2eb', '#cc65fe', '#ffce56', '#5a5c69', '#ff6384', '#A862D3'],
	    }],
	  },
	  options: {
		    responsive: false,
		    plugins: {
		      legend: {
		        position: 'top',
		      },
		      title: {
		        display: true,
		        text: 'Project Based Chart'
		      }
		    }
		  },
	});
