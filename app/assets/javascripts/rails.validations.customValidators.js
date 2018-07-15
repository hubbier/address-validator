// The validator variable is a JSON Object
// The selector variable is a jQuery Object
window.ClientSideValidations.validators.local['address'] = function(element, options) {
    // var params = $.param({
    //     Address: $("#address_street_address").val(),
    //     City: $("#address_city").val(),
    //     Region: $("#address_state").val(),
    //     Postal: $("#address_zip_code").val(),
    //     outFields: "*",
    //     forStorage: false,
    //     f: "pjson"
    // });
    // console.log(params);
    // $.ajax({
    //     url: $("#validate_address").data("gis-url") + "?" + params
    // }).done(function(response) {
    //     var candidates = JSON.parse(response).candidates;
    //     var matches = candidates.filter(function(candidate) { return candidate.score === "100"; });
    //     if (matches.length === 0) {
    //         return options.message
    //     }
    // }).fail(function(jqXHR, textStatus) {
    //     return options.message
    // });
    if ($.ajax({
      url: '/validators/arcgis',
      data: $("form").serialize(),
      async: false
    }).status == 404) { return options.message; }
}