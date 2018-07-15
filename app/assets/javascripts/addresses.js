// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
    $("#validate_address").on("click", function(e) {
        e.preventDefault();
        $("#notifications").empty();
        $("#success_message").hide();
        $.ajax({
            url: "/addresses",
            method: "POST",
            data: $("form").serialize(),
            dataType: "json"
        }).done(function(response) {
            $("#success_message").text(response.msg).show();
        }).fail(function(jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 404) {
                var errors = JSON.parse(jqXHR.responseText);
                $.each(errors, function(i, error) {
                    $("#notifications").append("<li>" + error + "</li");
                });                
            }
            else {
                $("#notifications").append(
                    "<li>There was a problem connecting to the server. " +
                    "If it persist, please contact " + 
                    "<a href='mailto:support@vote.org'>support@vote.org</a></li");
            }
        });
    });
});
