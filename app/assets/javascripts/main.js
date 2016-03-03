$(document).ready(function() {
  $('#complete_tasks').sortable({
    connectWith: "#incomplete_tasks",
    update: function() {
      var ids =$(this).sortable('serialize');
      $.post("/tasks/sort", ids);
    }
  });
  $('#incomplete_tasks').sortable({
    connectWith: '#complete_tasks',
    update: function() {
      var ids =$(this).sortable('serialize');
      $.post("/tasks/sort", ids);
    }
  });
});
