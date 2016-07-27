$(document).ready(function(){

	$('table .send').click(function(){
		var id = $(this).attr("id");
		$('input#taskuser_task_id').val(id);

		if ($('#form_send').css("display") === "none"){
			$('#form_send').show();}
		else{
			$('#form_send').hide();}
	});
});




