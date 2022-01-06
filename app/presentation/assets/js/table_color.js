// function displaycolor(value, row, index) {
//   //   var a = "";
//   //   if (value < 0) {
//   //     var a = '<style="color:#FF0000">' + value;
//   //   }
//   console.log(row);
//   return {
//     classes: value < 0 ? '<style="color:#FF0000>' : " ",
//   };
// }
$('tbody tr td:not(":first")').each(function () {
  var score = $(this).text();
  console.log(score);
  if (score >= 0) {
    $(this).addClass("pos");
  } else if (score < 0) {
    $(this).addClass("neg");
  } else if (score == "BEAR") {
    $(this).addClass("bear");
  } else if (score == "BULL") {
    $(this).addClass("bull");
  }
  
});
