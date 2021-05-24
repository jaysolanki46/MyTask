var ctx = document.getElementById('projectHours').getContext('2d');
var pieTasks = document.getElementById('pieTasks').value;
var pieTaskHours = document.getElementById('pieTaskHours').value;

var myPieChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
		  labels: pieTasks.split(','),
	      datasets: [{
	      data: pieTaskHours.split(','),
	      backgroundColor: ['#b81b44', '#0066cb', '#BC5090', '#FF6361', '#FFA600', '#6050DC', '#D52DB7', '#FF2E7E', '#FF6B45', '#FFAB05'],
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
		      }
		    }
		  },
	});
