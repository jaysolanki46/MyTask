var ctx = document.getElementById('myChart').getContext('2d');
var pieTasks = document.getElementById('pieTasks').value;
var pieTaskHours = document.getElementById('pieTaskHours').value;

var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		  labels: pieTasks.split(','),
	      datasets: [{
	      data: pieTaskHours.split(','),
	      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#5a5c69'],
	      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
	      hoverBorderColor: "rgba(234, 236, 244, 1)",
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
