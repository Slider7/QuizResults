let addQuizBtn = document.querySelector('#addQuiz');

function addQuiz() {
  let xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector("#add-result").innerHTML = this.responseText;
        }
    };
    let qProgram = document.querySelector('#q-program').value;
    let qUnit = document.querySelector('#q-unit').value;
    let qCode = `${qProgram}_${qUnit}`;

    if (qProgram == '') {
      alert('Не задана программа Quiza.');
      return ;
    }
    var formData = new FormData(document.forms.addquiz);
    // добавить к пересылке ещё пару ключ - значение
    formData.append("q-code", qCode);
    // отослать
    xmlhttp.open("POST", `./reports/addQuiz.php` , true);
    xmlhttp.send(formData);
}

addQuizBtn.addEventListener("click", function(e){
  document.querySelector('.add-quiz-form').classList.toggle('hidden-form');
  if (addQuizBtn.textContent == 'Добавить Quiz') {
    addQuizBtn.textContent = 'Закрыть форму Quiz-a';
  } else {
    addQuizBtn.textContent = 'Добавить Quiz';
  }
});

function showAddRep(){
  let showAddRepBtn = document.querySelector('#showAddRep');
  document.querySelector("#qr-data-container").classList.toggle('hidden');
  document.querySelector(".report-section").classList.toggle('hidden');
  document.querySelector('.add-quiz-form').classList.add('hidden-form');
  document.querySelector(".teach-quiz").classList.remove('off');
  if (showAddRepBtn.textContent == 'Дополнительно') {
    showAddRepBtn.textContent = 'Скрыть доп.функции';
    document.querySelector("#detail-report").classList.add('off');
    document.querySelector(".qr-detail").classList.add('off');
    showQuizzes();
  } else {
    showAddRepBtn.textContent = 'Дополнительно';
    document.querySelector("#adv-report").classList.add('off');
    document.querySelector(".adv-detail").classList.add('off');
    selectTeacher();
  }
};

document.getElementById('showAddRep').addEventListener("click", showAddRep, false);