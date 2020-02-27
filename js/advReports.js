function showQuizzes() {
  document.querySelector(".adv-detail").innerHTML = '';
  let xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".qr-data").innerHTML = this.responseText;
          addQuizResultRowHandlers();
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
        let col_names =[`rNum`, `quiz_code`, `fio`, `stud_code`, `teacher`, `user_score`, `pass_score`, `stud_percent`, `finished_at`, `quiz_time`, `qr_id`];
        Array.prototype.forEach.call(e.target.parentNode.cells, 
          (elem, i) => { qr_rowData[col_names[i]] = elem.textContent;
        });
        //console.log(qr_rowData);
        showQuizDetais(qr_rowData['qr_id']);
      })
    }
  };
}

function showQuizDetais(qr_id) {
  let xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".adv-detail").innerHTML = this.responseText;
          $('table.resizable').resizableColumns();
        }
    };
    xmlhttp.open("GET", `./reports/quiz_detail.php?qr_id=${qr_id}` , true);
    xmlhttp.send();
}

let btnTeachRep = document.getElementById('teach-rep');

btnTeachRep.addEventListener("click", function(event){
  let xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.querySelector("#qr-data-container").classList.remove('hidden');
        document.querySelector(".teach-quiz").classList.add('off');
        document.querySelector(".adv-detail").innerHTML = this.responseText;
      }
  };
  let d1 = document.getElementById('qr-start').value;
  let d2 = document.getElementById('qr-end').value;
  let qstr = `${d1}&d2=${d2}`;
  xmlhttp.open("GET", `./reports/teach-report.php?d1=${qstr}` , true);
  xmlhttp.send();
});

let btnAllRep = document.getElementById('all-rep');
btnAllRep.addEventListener("click", function(event){
  let d1 = document.getElementById('qr-start').value;
  let d2 = document.getElementById('qr-end').value;
  let qstr = `${d1}&d2=${d2}`;
  window.location.href = `./reports/quest-report.php?d1=${qstr}`;
});
