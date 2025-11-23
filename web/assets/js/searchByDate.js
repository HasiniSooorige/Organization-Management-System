let minDate, maxDate;
 
// Custom filtering function which will search data in column four between two values
DataTable.ext.search.push(function (settings, data, dataIndex) {
    let min = minDate.val();
    let max = maxDate.val();
    let date = new Date(data[4]);
 
    if (
        (min === null && max === null) ||
        (min === null && date <= max) ||
        (min <= date && max === null) ||
        (min <= date && date <= max)
    ) {
        return true;
    }
    return false;
});
 
// Create date inputs
minDate = new DateTime('#min', {
    format: 'yyyy-MM-dd'
});
maxDate = new DateTime('#max', {
    format: 'yyyy-MM-dd'
});

// DataTables initialisation
let table = document.getElementById('loadPortalPayment_table');
 
// Refilter the table
document.querySelectorAll('#min, #max').forEach((el) => {
    el.addEventListener('change', () => table.draw());
});