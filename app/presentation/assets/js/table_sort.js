$(document).ready(function () {
  // console.log(JSON.stringify($("#sortable").text()));

  table = $("#sortable").DataTable({
    // ordering: true,
    // order: [2, "desc"],
    initComplete: function (settings, json) {},
    language: {
      sProcessing: "Processing.",
      sLengthMenu: "show _MENU_ records",
      sZeroRecords: "none record",
      sInfo: "No._START_ - No._END_, total _TOTAL_ records",
      sInfoEmpty: "show 0 to 0 records，total: 0",
      sInfoFiltered: "(filter _MAX_ results)",
      sInfoPostFix: "",
      sSearch: "search:",
      sUrl: "",
      sEmptyTable: "no data",
      sLoadingRecords: "Loading...",
      sInfoThousands: ",",
      oPaginate: {
        sFirst: "First",
        sPrevious: "Previous",
        sNext: "Next",
        sLast: "Last",
      },
    },
    buttons: ["copy", "excel", "colvis"],
  });

  table.buttons().container().appendTo("#example_wrapper .col-md-6:eq(0)");
});
