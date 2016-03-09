$(document).ready(function(){
  $("#fetch-projects").on("click", function() {
    $.ajax({
      url: "http://localhost:3000/api/v1/projects?api_key=1559805d3acf5bcc51d0d729fb8e0ea672b0f1d2428926e0edb445a3710cc1c1",
      method: "GET",
      errors: function(){
        alert("Something went wrong...Please try again");
      },
      success: function(data){
        $("#projects-wrapper").html("");
        var template = $("#project_template").html();
        var projects = data.projects;
        // debugger
        for (var i = 0; i < projects.length; i++) {
          var renderedHtml = Mustache.render(template, projects[i]);
          $("#projects-wrapper").append(renderedHtml);
        }
      }
    });
  });
});
