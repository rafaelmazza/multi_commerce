$(document).ready(function() {
  // $('#bulk_action').val('bulk_delete'); 
  // jQuery('#bulk_form').submit(); return false;
  $('a.bulk_action').click(function() {
    // $('#' + 'bulk_prospect' + '_form').submit(); 
    if ($(':checked').length > 0) {
      $('#bulk_form').submit(); 
    } else {
      alert('nothing selected');
    }
    return false;
  });
  
  $('#toggle-checkboxes').click(function() {
      // var checkBoxes = $("input[type=checkbox]").except(this);
      var checkBoxes = $("input:checkbox:not('#toggle-checkboxes')");
      console.log(checkBoxes);
      checkBoxes.attr("checked", !checkBoxes.attr("checked"));
  });
  
  $('.date').datepicker()
});
