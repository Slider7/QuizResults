function showQuizzes() {
  document.querySelector(".adv-detail").innerHTML = '';
  let xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".qr-data").innerHTML = this.responseText;
          addQuizResultRowHandlers();
          document.querySelector('#teach-rep').textContent = 'Преподаватели и тесты';
        }
    };
    let elem = document.querySelector("#teach-select");
    let teacher_fio = elem.options[elem.selectedIndex].value;
    let d1 = document.getElementById('qr-start').value;
    let d2 = document.getElementById('qr-end').value;
    let qstr = `${d1}&d2=${d2}&teacher=${teacher_fio}`;
    xmlhttp.open("GET", `./reports/quiz_results.php?d1=${qstr}` , true);
    xmlhttp.send();
    document.querySelector("#adv-report").classList.remove('off');
    document.querySelector(".adv-detail").classList.remove('off');
    document.querySelector(".teach-quiz").classList.remove('off');
    document.querySelector("#qr-data-container").classList.remove('hidden');
    

}

function addQuizResultRowHandlers() {
  if (document.getElementById("qr-table")) {
    var rows = document.getElementById("qr-table").rows;
    for (i = 0; i < rows.length; i++) {
      rows[i].addEventListener("click", function(e){
        let selected = document.querySelector('#qr-body .selected');
        if (selected) {
          selected.classList.remove('selected');
        }
        e.target.parentNode.classList.add('selected');
        let qr_rowData = {};
        let col_names =[`rNum`, `stud_name`, `fio`, `stud_code`, `teacher`, `user_score`, `pass_score`, `stud_percent`, `finished_at`, `quiz_time`, `qr_id`];
        Array.prototype.forEach.call(e.target.parentNode.cells, 
          (elem, i) => { qr_rowData[col_names[i]] = elem.textContent;
        });
        showQuizDetais(qr_rowData['qr_id'], qr_rowData['stud_name']);
      })
    }
  };
}

function showQuizDetais(qr_id, fio) {
  let xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".adv-detail").innerHTML = this.responseText;
          $('table.resizable').resizableColumns();
        }
    };
    xmlhttp.open("GET", `./reports/quiz_detail.php?qr_id=${qr_id}&fio=${fio}` , true);
    xmlhttp.send();
}

//асинхронное получение отчета из Php скрипта
function getTeacherReport(){
  let d1 = document.getElementById('qr-start').value;
  let d2 = document.getElementById('qr-end').value;
  let qstr = `${d1}&d2=${d2}`;
  fetch(`./reports/teach-report.php?d1=${qstr}`)
    .then(response => response.text())
    .then((data) => {
      document.querySelector("#qr-data-container").classList.remove('hidden');
      document.querySelector(".teach-quiz").classList.add('off');
      document.querySelector(".adv-detail").innerHTML = data;
      document.querySelector("#xlsTeacherBtn").classList.remove('off');
      document.querySelector('#teach-rep').textContent = 'Результаты тестов';
    })
    .catch(error => console.error(error));
}

function btnTeachHandler(){
  let flag = document.querySelector('#teach-rep').textContent == 'Преподаватели и тесты';
  if (flag) {
    getTeacherReport();
  } else {
    showQuizzes();
  }
}

let btnTeachRep = document.getElementById('teach-rep');
btnTeachRep.addEventListener("click", btnTeachHandler, false);

let btnAllRep = document.getElementById('all-rep');
btnAllRep.addEventListener("click", function(event){
  let d1 = document.getElementById('qr-start').value;
  let d2 = document.getElementById('qr-end').value;
  let qstr = `${d1}&d2=${d2}`;
  window.location.href = `./reports/quest-report.php?d1=${qstr}`;
});

function teacherTableToExcel(){
  let uri = 'data:application/vnd.ms-excel;base64,', 
  template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
  base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },
  format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) };
  return function() {
  table = document.getElementById('teacher-avg');
  let tStr = table.innerHTML;
  let ctx = {worksheet: 'Отчет', table: tStr};
  let link = document.createElement("a");
  link.download = 'Teachers-avg-results.xls';
  link.href = uri + base64(format(template, ctx));
  link.click();
  }
};

document.querySelector('#xlsTeacherBtn').addEventListener('click', function(){teacherTableToExcel()();}, false);