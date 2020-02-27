let d = new Date();
d.setDate(d.getDate() - 30);
document.getElementById('qr-start').valueAsDate = d;
document.getElementById('qr-end').valueAsDate = new Date();

function getPeriodQuery(){
  if (!document.getElementById('isPeriod').checked) return ``;
  let d1 = document.getElementById('qr-start').value;
  let d2 = document.getElementById('qr-end').value;
  return `&d1=${d1}&d2=${d2}`;
}

function checkPeriod(){ 
  document.getElementById('period').classList.toggle('none');
}
//асинхронное получение списка из Php скрипта
function fillTeachersList(){
  let teachSel = document.querySelector("#teach-select");
  getTeacherList(`./reports/teachers.php`)
    .then((data) => {
      if (data.length > 0) {
        data.forEach((item)=>{
          let opt = document.createElement('option');
          opt.appendChild( document.createTextNode(item) );
          opt.value = item; 
          teachSel.appendChild(opt); 
        });
      }
    })
    .catch(error => console.error(error));
}

function getTeacherList(url) {
    return fetch(url)
    .then(response => response.json()); // парсит JSON ответ в Javascript объект
}

fillTeachersList();

function selectTeacher(e){
  document.querySelector("#qr-data-container").classList.add('hidden');
  document.querySelector("#detail-report").classList.add('hidden');
  let elem = document.querySelector("#teach-select");
  let teacher_fio = elem.options[elem.selectedIndex].value;
  let fio_text = elem.options[elem.selectedIndex].text;
  document.querySelector("#teacher-fio").innerHTML = fio_text;
  let xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".qr-data").innerHTML = this.responseText;
          document.querySelector(".qr-data").style.height = 'auto';
          document.querySelector("#qr-data-container").classList.remove('hidden');
          addTeachQuizRowHandlers();
        }
    };
  xmlhttp.open("GET", `./reports/teacher_quiz.php?teacher=${teacher_fio}${getPeriodQuery()}` , true);
  xmlhttp.send();
};

document.getElementById('teach-select').addEventListener("change", selectTeacher, false);

selectTeacher();

function addTeachQuizRowHandlers() {
  if (document.getElementById("teach-quiz-table")) {
    var rows = document.getElementById("teach-quiz-table").rows;
    for (i = 0; i < rows.length; i++) {
      rows[i].addEventListener("click", function(e){
        let selected = document.querySelector('#qr-body .selected');
        let teacher_fio = document.querySelector("#teach-select").value;
        let quizCode = '';
        if (selected) {
          selected.classList.remove('selected');
        }
        e.target.parentNode.classList.add('selected');
        let qr_rowData = {};
        let col_names =[`rNum`, `teacher`, `program`, `level`, `unit`, `gruppa`];
        Array.prototype.forEach.call(e.target.parentNode.cells, 
          (elem, i) => { qr_rowData[col_names[i]] = elem.textContent;
        });
        quizCode = qr_rowData['program'].trim();
        quizCode += qr_rowData['level'].trim();
        quizCode += '_';
        quizCode += qr_rowData['unit'].trim();
        showStudentQuizDetais(quizCode, qr_rowData['teacher'].trim(), qr_rowData['gruppa']);
        document.querySelector("#table-title").innerHTML = 
        `Анализ тестирования ${quizCode} преподавателя ${teacher_fio}, группа ${qr_rowData['gruppa']}`; 
      })
    }
  };
}

function showStudentQuizDetais(quiz_code, teacher, gruppa) {
  let xmlhttp = new XMLHttpRequest();
  let qr_ids = [];
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          qr_ids = JSON.parse(this.responseText);
          buildGruppaTable(qr_ids);
        }
    };
    xmlhttp.open(
      "GET", 
      `./reports/get-result-ids-by-gruppa.php?quiz_code=${quiz_code}&teacher=${teacher}&gruppa=${gruppa}${getPeriodQuery()}`,
      true
    );
    xmlhttp.send();
    document.querySelector("#detail-report").classList.remove('hidden');
}

function buildGruppaTable(ids){
  document.querySelector("#gruppa-matrix").innerHTML = '';
  let xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.querySelector("#gruppa-matrix-head").innerHTML = 
        `<tr><th class='fio-stud'>ФИО курсанта</th> ${this.responseText} 
        <th>Проходной балл</th><th>Получено баллов</th><th>Результат(%)</th>
        <th>Статус</th></tr>`;
    }
  };
  xmlhttp.open("GET", `./reports/get-quiz-row.php?qr_id=${ids[0][0]}&is_header=1`, true);
  xmlhttp.send();

  ids.forEach(function(item, i) {
    let xmlhttp = new XMLHttpRequest();
    let isOk = '', res = '';
    if (parseFloat(item[3]) < parseFloat(item[4])) {
      isOk = 'bad';
      res = 'fail';
    } else {
      isOk = 'good';
      res = 'OK';
    } 

    xmlhttp.onreadystatechange = function() {	
      if (this.readyState == 4 && this.status == 200) {
           document.querySelector("#gruppa-matrix").innerHTML += 
         `<tr><td>${item[1]}</td> ${this.responseText} 
         <td class='result-prc'>${item[4]}</td>
         <td class='result-prc'>${item[3]}</td>
         <td class='result-prc'>${item[2]}</td>
         <td class='result-prc ${isOk}'>${res}</td>
         </tr>`;
      }
    };
    xmlhttp.open("GET", `./reports/get-quiz-row.php?qr_id=${item[0]}`, true);
    xmlhttp.send();
  });
}

function tableToExcel() {
  let uri = 'data:application/vnd.ms-excel;base64,', 
      template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
      base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },
      format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) };
  return function() {
    table = document.getElementById('matrix-table');
    let tStr = table.innerHTML;
    let re = /ans">(.*?)<\/td>/g;
    matchAll = tStr.matchAll(re); //классный метод matchAll !!!
    matchAll = Array.from(matchAll);
    let findStr = matchAll.map(elem=>elem[1]);
    let points = findStr.map(str=> {
      let d = str.indexOf('/');
      let a = parseFloat(str.substr(0, d));
      let b = parseFloat(str.substr(d+1));
      return (a/b).toFixed(3);
    });

    findStr.forEach((elem, i)=>{
      tStr = tStr.replace(elem, points[i].replace('.', ','));
    });
    // console.log(tStr);
    let ctx = {worksheet: 'Отчет', table: tStr};
    //window.location.href = uri + base64(format(template, ctx));
    let link = document.createElement("a");
    link.download = document.querySelector("#teach-select").value + '.xls';
    link.href = uri + base64(format(template, ctx));
    link.click();
  }
};