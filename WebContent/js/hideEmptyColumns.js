function hideEmptyCols(standardTable, exportTable) {
	this.hideStandardTableCols(standardTable);
	this.makeIdEmptyColsForExport(exportTable);
	this.removeEmptyColsForExport(exportTable);
}

function hideStandardTableCols(table) {
	
    var numCols = $("th", table).length;
    for ( var i=5; i<=numCols-1; i++ ) {
        var empty = true;
        $("td:nth-child(" + i + ")", table).each(function(index, el) {
            if ( $("label", el).text() != "-" ) {
                empty = false;
                return false; 
            }
        });
        if ( empty ) {
            $("td:nth-child(" + i + ")", table).hide(); //hide <td>'s
            $("th:nth-child(" + i + ")", table).hide(); //hide header <th>
        }
    }
}

function makeIdEmptyColsForExport(table) {
	
    var numCols = $("th", table).length;
    for ( var i=6; i<=numCols-1; i++ ) {
        var empty = true;
        $("td:nth-child(" + i + ")", table).each(function(index, el) {
            if ( $("label", el).text() != "-" ) {
                empty = false;
                return false; 
            }
        });
        if ( empty ) {
            //$("td:nth-child(" + i + ")", table).attr('class', 'empty'); //hide <td>'s
            $("th:nth-child(" + i + ")", table).attr('class', 'empty'); //hide header <th>
        }
    }
}

function removeEmptyColsForExport(table) {
	
	let numCols = document.getElementsByClassName('empty').length;
	var target = $(table).find('th[class="empty"]');
	var index = (target).index();
	
	while(index != -1) {
		$(table + ' tr').find('th:eq(' + index + '),td:eq(' + index + ')' ).remove();
		target = $(table).find('th[class="empty"]');
		index = (target).index();
	}
}