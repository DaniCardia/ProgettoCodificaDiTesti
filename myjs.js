
// Mostra le informazioni nascoste
function showHiddenDescription(testo) {
  var lista = ['note', 'informazioni', 'caratteristiche', 'collocazione'];
  var x = document.getElementById(testo);
  if (x.style.display === "none") {
    x.style.display = "grid";
  } else {
    x.style.display = "none";
  }
  lista.forEach(element => {
    if(element.localeCompare(testo) != 0) {
      console.log(testo)
      e = document.getElementById(element);
      e.style.display = "none";
    }
  });
} 

// Immagini
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("immagine");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}

function selectText(areaImmagine){
  var x = document.getElementsByName(areaImmagine);
  len = x['length']
  for (let i = 0; i < len; i++) {
    element = x[i];
    element.style.backgroundColor="aquamarine";
  }
}

function deselectText(areaImmagine){
  var x = document.getElementsByName(areaImmagine);
  len = x['length']
  for (let i = 0; i < len; i++) {
    element = x[i];
    element.style.backgroundColor="transparent";
  }
}

// bottoni descrizione Bellini e Florimo
function showProfile(nome) {
  var lista = ['Bellini', 'Florimo'];
  var x = document.getElementById(nome);
  if (x.style.display === "none") {
    x.style.display = "grid";
    if (nome == "Florimo"){
      x.parentNode.style.gridColumn = 2;
    } else{
      x.parentNode.style.gridColumn = 1;
    }
  } else {
    x.style.display = "none";
  }
  lista.forEach(element => {
    if(element.localeCompare(nome) != 0) {
      e = document.getElementById(element);
      e.style.display = "none";
    }
  });
} 
